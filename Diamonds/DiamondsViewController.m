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

#ifdef TEST
xxxxxx
#endif

@interface DiamondsViewController ()

@property (nonatomic, assign) CADisplayLink *displayLink;

@end

@implementation DiamondsViewController
{
    DiamondsGame* game;
}

@synthesize animating, displayLink;

- (void) addGestures
{
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(handleTapFrom:)];
    
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer: tap];
    
    UISwipeGestureRecognizer* swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(handleSwipeLeftFrom:)];
    
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer: swipeLeft];
    
    UISwipeGestureRecognizer* swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(handleSwipeRightFrom:)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer: swipeRight];    

    UISwipeGestureRecognizer* swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(handleSwipeDownFrom:)];
    
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer: swipeDown];    
}

- (void) initializeGame
{
    Engine* engine = [[Engine alloc] initWithView: (EAGLView*) self.view];
    game = [[DiamondsGame alloc] initWithEngine: engine];
    
    ResourceManager* resources = [ResourceManager new];
    [game loadResources: resources];    
    
    [self addGestures];    
}

- (void) handleTapFrom: (UITapGestureRecognizer*) recognizer
{
    CGPoint point = [recognizer locationInView: self.view];

    if (point.x < self.view.bounds.size.width / 2)
    {
        [game moveLeft];
    }
    else
    {
        [game moveRight];
    }
}

- (void) handleSwipeLeftFrom: (UITapGestureRecognizer*) recognizer
{
    [game rotateLeft];
}

- (void) handleSwipeRightFrom: (UITapGestureRecognizer*) recognizer
{
    [game rotateRight];
}

- (void) handleSwipeDownFrom: (UITapGestureRecognizer*) recognizer
{
    [game drop];
}

- (void) awakeFromNib
{    
    animating = FALSE;
    animationFrameInterval = 1;
    self.displayLink = nil;
    
#ifndef TEST
    [self initializeGame];
#endif
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
