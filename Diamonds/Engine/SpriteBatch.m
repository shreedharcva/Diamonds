//
//  Sprite.m
//  Diamonds

#import "SpriteBatch.h"

#import "Sprite.h"
#import "ShaderProgram.h"
#import "Texture.h"
#import "Engine.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import <GLKit/GLKMath.h>

void getProjectionMatrix(Engine* engine, GLKMatrix4* matrix)
{
    CGSize windowSize = engine.windowSize;
    
    *matrix = GLKMatrix4MakeOrtho(0, windowSize.width, windowSize.height, 0, -1, 1);
    *matrix = GLKMatrix4Transpose(*matrix);
}

static ShaderProgram* program;

@implementation SpriteBatch
{
    Engine* engine;
    ShaderProgram* shaderProgram;

    bool spriteBatchStarted;
}

- (id) initWithEngine: (Engine*) theEngine
{
    self = [super init];
    if (self == nil)
        return nil;
    
    engine = theEngine;

    if (program == 0)
    {
        program = [ShaderProgram new];
        [program load];
    }
    
    shaderProgram = program;
    
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
    
    glEnable (GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
}

- (void) end
{
    spriteBatchStarted = false;
}

- (void) drawQuad: (CGPoint) position size: (CGSize) size texture: (Texture*) texture sourceRect: (CGRect) source
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
    
    float src_x0 = source.origin.x / texture.size.width;
    float src_y0 = source.origin.y / texture.size.width;
    float src_x1 = (source.origin.x + source.size.width)  / texture.size.width;
    float src_y1 = (source.origin.y + source.size.height) / texture.size.height;

    const GLfloat texCoords[8] = 
    {
        src_x0, src_y0,
        src_x1, src_y0,
        src_x0, src_y1,
        src_x1, src_y1
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