//
//  Engine.m
//  Diamonds

#import "Engine.h"
#import "Texture.h"
#import "ShaderProgram.h"

#import "EAGLView.h"

#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface Engine ()
{
    EAGLView* view;
    
    EAGLContext *glcontext;
    
    ShaderProgram* shaderProgram;
    Texture* textureObject;
}

@end


@implementation Engine

- (id) initWithView: (EAGLView*) glview
{
    self = [super init];
    if (self == nil)
        return nil;

    view = glview;    
    
    EAGLContext *aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!aContext)
    {
        NSLog(@"Failed to create ES context");
        return nil;
    }
    if (![EAGLContext setCurrentContext:aContext])
    {
        NSLog(@"Failed to set ES context current");
        return nil;
    }
    
	glcontext = aContext;
	[aContext release];
    
    [view setContext: glcontext];
    [view setFramebuffer];
    [view createResources];
    
    shaderProgram = [ShaderProgram new];

    [self loadShaders];
    [self loadTextures];
   
    return self;
}

- (void) dealloc
{ 
    [shaderProgram release];
    [textureObject release];
    
    if ([EAGLContext currentContext] == glcontext)
        [EAGLContext setCurrentContext:nil];
    
    [glcontext release];

    [super dealloc];
}

- (void) loadShaders
{    
    [shaderProgram load];

    return;
}

-  (void) loadTextures
{
    textureObject = [Texture new];
    [textureObject load];
}


- (void) drawFrame
{
    [view setFramebuffer];
    
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
    [shaderProgram setParamter: UNIFORM_TRANSLATE with1f: transY];
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
    
    [view presentFramebuffer];
}


@end
