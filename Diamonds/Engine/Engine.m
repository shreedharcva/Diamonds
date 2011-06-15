//
//  Engine.m
//  Diamonds

#import "Engine.h"
#import "ShaderProgram.h"

#import "EAGLView.h"

@implementation Engine

@synthesize view;

@synthesize glcontext;
@synthesize texture;

- (id) initWithView: (EAGLView*) glview
{
    self = [super init];
    if (self == nil)
        return nil;

    self.view = glview;    
    
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
    
    [self.view setContext: glcontext];
    [self.view setFramebuffer];
    [self.view createResources];
    
    shaderProgram = [ShaderProgram new];

    [self loadShaders];
    [self loadTextures];
   
    return self;
}

- (void) dealloc
{ 
    [shaderProgram release];
    
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
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR); 
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ruby" ofType:@"png"];
    NSData *texData = [[NSData alloc] initWithContentsOfFile:path];
    UIImage *image = [[UIImage alloc] initWithData:texData];
    if (image == nil)
        NSLog(@"Do real error checking here");
    
    GLuint width = CGImageGetWidth(image.CGImage);
    GLuint height = CGImageGetHeight(image.CGImage);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    void *imageData = malloc( height * width * 4 );
    
    CGContextRef context = CGBitmapContextCreate( imageData, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
    
    CGColorSpaceRelease( colorSpace );
    
    CGContextClearRect( context, CGRectMake( 0, 0, width, height ) );
    CGContextTranslateCTM( context, 0, height - height );
    CGContextDrawImage( context, CGRectMake( 0, 0, width, height ), image.CGImage );
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
    
    CGContextRelease(context);
    
    free(imageData);
    
    [image release];
    [texData release];    
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
    [shaderProgram setParamter: UNIFORM_TEXTURE withTexture: texture];
           
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
    
    [self.view presentFramebuffer];
}


@end
