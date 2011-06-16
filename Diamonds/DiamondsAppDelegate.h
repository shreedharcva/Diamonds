//
//  DiamondsAppDelegate.h
//  Diamonds

#import <UIKit/UIKit.h>

@class DiamondsViewController;
@class EAGLView;

@interface DiamondsAppDelegate : NSObject <UIApplicationDelegate> 
{
    EAGLView* glView;
}

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain) IBOutlet UIWindow* controllerWindow;

@property (nonatomic, retain) IBOutlet DiamondsViewController* viewController;
@property (nonatomic, retain) IBOutlet EAGLView* glView;

@end
