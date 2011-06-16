//
//  Sprite.m
//  Diamonds

#import "Sprite.h"
#import "ShaderProgram.h"
#import "Texture.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@implementation Sprite

@synthesize textureObject;
@synthesize shaderProgram;

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

- (void) draw
{
    // Replace the implementation of this method to do your own custom drawing.
    static const GLfloat squareVertices[] = 
    {
        -0.5f, -0.33f,
        0.5f, -0.33f,
        -0.5f,  0.33f,
        0.5f,  0.33f,
    };
    
    static const GLubyte squareColors[] = 
    {
        255, 255,   0, 255,
        0,   255, 255, 255,
        0,     0,   0,   0,
        255,   0, 255, 255,
    };
    
    static const GLfloat texCoords[] = 
    {
        0.0, 1.0,
        1.0, 1.0,
        0.0, 0.0,
        1.0, 0.0
    };
    
    static float transY = 0.0f;
    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [shaderProgram use];
    [shaderProgram setParameter: UNIFORM_TRANSLATE with1f: transY];
    [shaderProgram setParameter: UNIFORM_TEXTURE withTextureObject: textureObject];
    
    // Update attribute values.
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    glVertexAttribPointer(ATTRIB_COLOR, 4, GL_UNSIGNED_BYTE, 1, 0, squareColors);
    glEnableVertexAttribArray(ATTRIB_COLOR);
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