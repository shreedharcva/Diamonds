//
//  DiamondsViewController.m
//  Diamonds

#import <QuartzCore/QuartzCore.h>

#import "DiamondsViewController.h"
#import "EAGLView.h"

#import "Engine.h"

@interface DiamondsViewController ()

@property (nonatomic, assign) CADisplayLink *displayLink;

@end

@implementation DiamondsViewController

@synthesize animating, displayLink;

- (void)awakeFromNib
{
    engine = [[Engine alloc] initWithView: (EAGLView*) self.view];
    
    [engine loadShaders];
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

- (void) drawFrame
{
    [engine drawFrame];
}



@end
