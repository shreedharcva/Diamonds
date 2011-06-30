//
//  Sprite.m
//  Diamonds

#import "Sprite.h"
#import "SpriteBatch.h"
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

@implementation Sprite
{
    ShaderProgram* shaderProgram;
    Texture* textureObject;

    CGPoint position;
    CGSize size;
}

- (id) init
{
    self = [super init];
    if (self == nil)
        return nil;

    shaderProgram = [ShaderProgram new];
    [shaderProgram load];
    textureObject = [Texture new];
    
    [textureObject load];
    return self;
}

- (void) applyShaderUsing: (Engine*) engine 
{
    GLKMatrix4 projMatrix;
    getProjectionMatrix(engine, &projMatrix);

    [shaderProgram use];
    [shaderProgram setParameter: UNIFORM_MODEL_VIEW_PROJECTION_MATRIX withMatrix4f: projMatrix.m];
    [shaderProgram setParameter: UNIFORM_TRANSLATE with1f: 0.0];
    [shaderProgram setParameter: UNIFORM_TEXTURE withTextureObject: textureObject];
}

- (void) drawQuad 
{
    
    float width = textureObject.size.width;
    float height = textureObject.size.height;
 
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

- (void) moveTo: (CGPoint) newPosition
{
    position = newPosition;
}

- (void) resizeTo: (CGSize) newSize
{
    size = newSize;
}

- (void) drawUsingEngine: (Engine*) engine
{ 
    SpriteBatch* batch = [SpriteBatch new];
    
    [batch begin];

    [self applyShaderUsing: engine];
    [self drawQuad];
    
    [batch end];
}

- (void) drawIn: (SpriteBatch*) batch
{    
    [batch drawQuad: position size: size];
}

@end
