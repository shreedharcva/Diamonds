//
//  Game.h
//  Diamonds

@class Engine;
@class ResourceManager;

@interface GameTime : NSObject

@property (readonly) float milliseconds;
@property (readonly) float elapsedTimeInMilliseconds;

+ (GameTime*) gameTime: (float) milliseconds;

@end

@interface GameTimer : NSObject

- (GameTime*) getTime;

@end

@interface Game : NSObject

- (void) loadResources: (ResourceManager*) resources;

- (void) update: (GameTime*) gameTime;
- (void) draw: (GameTime*) gameTime;

@property (readonly, nonatomic) Engine* engine;

@end

@interface Game (Private) 

@property (readonly) GameTimer* timer;

- (id) initWithEngine: (Engine*) engine;

- (void) updateFrame;
- (void) drawFrame;

@end
