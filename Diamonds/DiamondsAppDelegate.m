//
//  DiamondsAppDelegate.m
//  Diamonds

#import "DiamondsAppDelegate.h"

#import "EAGLView.h"

#import "DiamondsViewController.h"

@interface DiamondsAppDelegate () 
{
    UIScreen* externalScreen;    
}

@end

@implementation DiamondsAppDelegate


@synthesize window;
@synthesize controllerWindow;

@synthesize viewController;
@synthesize glView;

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window.rootViewController = self.viewController;
    
    [self.window makeKeyAndVisible];
    
    if ([[UIScreen screens] count] > 1)
    {
        NSLog(@"Found external monitor...");
        
        NSArray* screenModes;
        
        externalScreen = [[[UIScreen screens] objectAtIndex: 1] retain];
        screenModes = externalScreen.availableModes;
        
        NSLog(@"Available modes:\n%@", screenModes);
        
        UIScreenMode* screenMode = [screenModes objectAtIndex: 0];
        self.window.screen = externalScreen;
         
        CGRect rect = CGRectZero;
        rect.size = screenMode.size;
        
        self.window.frame = rect;
        self.window.clipsToBounds = YES;
        self.window.hidden = NO;
        
        [self.window makeKeyAndVisible];
        [self.controllerWindow makeKeyAndVisible];
    }
    else
    {
        controllerWindow.frame = CGRectZero;;
        controllerWindow.clipsToBounds = YES;
        controllerWindow.hidden = YES;

        [controllerWindow resignKeyWindow];
    }
    
    return YES;
}

- (void) applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    [self.viewController stopAnimation];
}

- (void) applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void) applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    [self.viewController startAnimation];
}

- (void) applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    [self.viewController stopAnimation];
}


- (void) dealloc
{
    [window release];
    [viewController release];
    [super dealloc];
}

@end
