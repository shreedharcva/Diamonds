//
//  Sprite.m
//  Diamonds

#import "SpriteBatch.h"

#import "Sprite.h"
#import "ShaderProgram.h"
#import "Texture.h"
#import "Engine.h"

#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import <GLKit/GLKMath.h>


void getProjectionMatrix(Engine* engine, GLKMatrix4* matrix)
{
    CGSize windowSize = engine.windowSize;
    
    *matrix = GLKMatrix4MakeOrtho(0, windowSize.width, windowSize.height, 0, -1, 1);
    *matrix = GLKMatrix4Transpose(*matrix);
}

@implementation SpriteBatch
{
    Engine* engine;
    
    bool spriteBatchStarted;
}

- (id) initWithEngine: (Engine*) theEngine
{
    self = [super init];
    if (self == nil)
        return nil;
    
    engine = theEngine;

    shaderProgram = [ShaderProgram new];
    [shaderProgram load];

    return self;    
}

@synthesize engine;
@synthesize shaderProgram;

- (bool) isEmpty
{
    return YES;
}

- (void) begin
{
    spriteBatchStarted = true;

    GLKMatrix4 projMatrix;
    getProjectionMatrix([self engine], &projMatrix);
    
    [shaderProgram use];
    [shaderProgram setParameter: UNIFORM_MODEL_VIEW_PROJECTION_MATRIX withMatrix4f: projMatrix.m];
    [shaderProgram setParameter: UNIFORM_TRANSLATE with1f: 0.0];
}

- (void) end
{
    spriteBatchStarted = false;
}

- (void) drawQuad: (CGPoint) position size: (CGSize) size texture: (Texture*) texture
{
    if (!spriteBatchStarted)
    {
        @throw [NSException exceptionWithName:@"SpriteBatch" reason: @"SpriteBatch wasnt open" userInfo: nil];
    }
    
    [shaderProgram setParameter: UNIFORM_TEXTURE withTextureObject: texture];
    
    float width = size.width;
    float height = size.height;
    
    GLfloat squareVertices[8];
    
    float x = position.x;
    float y = position.y;
    
    squareVertices[0] = x;
    squareVertices[1] = y;
    
    squareVertices[2] = x + width;
    squareVertices[3] = y;
    
    squareVertices[4] = x;
    squareVertices[5] = y + height;
    
    squareVertices[6] = x + width;
    squareVertices[7] = y + height;
    
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    
    static const GLfloat texCoords[] = 
    {
        0.0, 1.0,
        1.0, 1.0,
        0.0, 0.0,
        1.0, 0.0
    };            
    
    glVertexAttribPointer(ATTRIB_TEXCOORD, 2, GL_FLOAT, 0, 0, texCoords);
    glEnableVertexAttribArray(ATTRIB_TEXCOORD);
    
#if defined(DEBUG)
    if (![shaderProgram validate]) 
    {
        NSLog(@"Failed to validate shader program");
        return;
    }
#endif
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}

@end