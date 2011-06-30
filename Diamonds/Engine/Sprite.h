//
//  Sprite.h
//  Diamonds


@class Engine;
@class SpriteBatch;

typedef struct Position
{
    float x;
    float y;
} 
Position;

@interface Sprite : NSObject 

- (void) moveTo: (Position) position;
- (void) drawUsingEngine: (Engine*) engine;
- (void) drawIn: (SpriteBatch*) batch;

@end