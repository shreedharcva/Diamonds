//
//  Sprite.h
//  Diamonds


@class Engine;
@class SpriteBatch;

@interface Sprite : NSObject 

- (void) moveTo: (CGPoint) newPosition;
- (void) resizeTo: (CGSize) size;

- (void) drawUsingEngine: (Engine*) engine;
- (void) drawIn: (SpriteBatch*) batch;

@end