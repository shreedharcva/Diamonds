//
//  DiamondsViewController.h
//  Diamonds

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@class Engine;

@interface DiamondsViewController : UIViewController 
{
@private

    BOOL animating;
    NSInteger animationFrameInterval;
    CADisplayLink* __unsafe_unretained displayLink;
    
    Engine* engine;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (void) startAnimation;
- (void) stopAnimation;

@end
