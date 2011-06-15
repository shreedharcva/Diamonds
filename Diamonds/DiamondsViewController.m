//
//  DiamondsViewController.m
//  Diamonds

#import <QuartzCore/QuartzCore.h>

#import "DiamondsViewController.h"
#import "EAGLView.h"

#import "Engine.h"


// Uniform index.
enum 
{
    UNIFORM_TRANSLATE,
    UNIFORM_TEXTURE,
    NUM_UNIFORMS
};

GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum 
{
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
    ATTRIB_TEXCOORD,
    NUM_ATTRIBUTES
};



@interface DiamondsViewController ()

@property (nonatomic, assign) CADisplayLink *displayLink;

- (BOOL) loadShaders;

@end

@implementation DiamondsViewController

@synthesize animating, displayLink;

- (void)awakeFromNib
{
    engine = [[Engine alloc] initWithView: (EAGLView*) self.view];
    
    [self loadShaders];
    [engine loadTextures];
    
    animating = FALSE;
    animationFrameInterval = 1;
    self.displayLink = nil;
}

- (void)dealloc
{
    [engine release];
    
    [super dealloc];
}

- (void) didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void) viewWillAppear: (BOOL) animated
{
    [self startAnimation];
    
    [super viewWillAppear: animated];
}

- (void) viewWillDisappear: (BOOL) animated
{
    [self stopAnimation];
    
    [super viewWillDisappear: animated];
}

- (void) viewDidUnload
{
	[super viewDidUnload];

    [engine release];
    engine = nil;
}

- (NSInteger) animationFrameInterval
{
    return animationFrameInterval;
}

- (void) setAnimationFrameInterval: (NSInteger) frameInterval
{
    /*
	 Frame interval defines how many display frames must pass between each time the display link fires.
	 The display link will only fire 30 times a second when the frame internal is two on a display that refreshes 60 times a second. The default frame interval setting of one will fire 60 times a second when the display refreshes at 60 times a second. A frame interval setting of less than one results in undefined behavior.
	 */
    if (frameInterval >= 1) 
    {
        animationFrameInterval = frameInterval;
        
        if (animating) {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

- (void) startAnimation
{
    if (!animating) 
    {
        CADisplayLink *aDisplayLink = [[UIScreen mainScreen] displayLinkWithTarget: self selector:@selector(drawFrame)];
        
        [aDisplayLink setFrameInterval:animationFrameInterval];
        [aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.displayLink = aDisplayLink;
        
        animating = TRUE;
    }
}

- (void) stopAnimation
{
    if (animating) 
    {
        [self.displayLink invalidate];
        self.displayLink = nil;
        animating = FALSE;
    }
}

- (void)drawFrame
{
    [(EAGLView *)self.view setFramebuffer];
    
    // Replace the implementation of this method to do your own custom drawing.
    static const GLfloat squareVertices[] = {
        -0.5f, -0.33f,
        0.5f, -0.33f,
        -0.5f,  0.33f,
        0.5f,  0.33f,
    };
    
    static const GLubyte squareColors[] = {
        255, 255,   0, 255,
        0,   255, 255, 255,
        0,     0,   0,   0,
        255,   0, 255, 255,
    };
    
    static const GLfloat texCoords[] = {
        0.0, 1.0,
        1.0, 1.0,
        0.0, 0.0,
        1.0, 0.0
    };
    
    static float transY = 0.0f;
    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    
    // Use shader program.
    glUseProgram(engine.program);
    
    // Update uniform value.
    glUniform1f(uniforms[UNIFORM_TRANSLATE], (GLfloat)transY);
    transY += 0.075f;	

    glActiveTexture(0);
    glBindTexture(GL_TEXTURE_2D, engine.texture);
    glUniform1i(uniforms[UNIFORM_TEXTURE], 0);

    
    // Update attribute values.
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    glVertexAttribPointer(ATTRIB_COLOR, 4, GL_UNSIGNED_BYTE, 1, 0, squareColors);
    glEnableVertexAttribArray(ATTRIB_COLOR);
    glVertexAttribPointer(ATTRIB_TEXCOORD, 2, GL_FLOAT, 0, 0, texCoords);
    glEnableVertexAttribArray(ATTRIB_TEXCOORD);
        
    // Validate program before drawing. This is a good check, but only really necessary in a debug build.
    // DEBUG macro must be defined in your debug configurations if that's not already the case.
#if defined(DEBUG)
    if (![engine validateProgram:engine.program]) 
    {
        NSLog(@"Failed to validate program: %d", engine.program);
        return;
    }
#endif
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    [(EAGLView *) self.view presentFramebuffer];
}

- (BOOL)loadShaders
{
    [engine loadShaders];
    
    // Get uniform locations.
    uniforms[UNIFORM_TRANSLATE] = glGetUniformLocation(engine.program, "translate");
    uniforms[UNIFORM_TEXTURE] = glGetUniformLocation(engine.program, "texture");

    return TRUE;
}


@end
