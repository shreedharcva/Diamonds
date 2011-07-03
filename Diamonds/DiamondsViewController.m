//
//  DiamondsViewController.m
//  Diamonds

#import <QuartzCore/QuartzCore.h>

#import "DiamondsViewController.h"
#import "EAGLView.h"

#import "Engine.h"
#import "Sprite.h"
#import "SpriteBatch.h"
#import "ResourceManager.h"

#import "DiamondsGame.h"

@interface DiamondsViewController ()

@property (nonatomic, assign) CADisplayLink *displayLink;

@end

@implementation DiamondsViewController
{
    DiamondsGame* game;
}

@synthesize animating, displayLink;

- (void) awakeFromNib
{    
    animating = FALSE;
    animationFrameInterval = 1;
    self.displayLink = nil;

    Engine* engine = [[Engine alloc] initWithView: (EAGLView*) self.view];
    game = [[DiamondsGame alloc] initWithEngine: engine];
    
    ResourceManager* resources = [ResourceManager new];
    [game loadResources: resources];
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

    game = nil;
}

- (NSInteger) animationFrameInterval
{
    return animationFrameInterval;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);    
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
        
        if (animating) 
        {
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
        
        [aDisplayLink setFrameInterval: animationFrameInterval];
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
    [game updateFrame];
    [game drawFrame];
}

@end
