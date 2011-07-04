//
//  Game.h
//  Diamonds


@class Engine;
@class ResourceManager;

@interface GameTime : NSObject

@property (readonly) float milliseconds;
@property (readonly) float elapsedTimeInMilliseconds;

@end

@interface GameTimer : NSObject
@end

@interface Game : NSObject

@property (readonly) Engine* engine;

- (id) initWithEngine: (Engine*) theEngine;

- (void) loadResources: (ResourceManager*) manager;
- (void) update: (GameTime*) gameTime;
- (void) draw: (GameTime*) gameTime;

- (void) updateFrame;
- (void) drawFrame;

@end

