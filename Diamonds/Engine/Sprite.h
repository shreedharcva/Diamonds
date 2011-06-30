//
//  Sprite.h
//  Diamonds


@class Engine;
@class SpriteBatch;

@interface Sprite : NSObject 

- (void) moveTo: (CGPoint) newPosition;
- (void) resizeTo: (CGSize) size;

- (void) drawIn: (SpriteBatch*) batch;

@end