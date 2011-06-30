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

@interface SpriteBatch : NSObject 

@property (readonly) Engine* engine;

- (id) initWithEngine: (Engine*) theEngine;

- (bool) isEmpty;

- (void) begin;
- (void) end;

- (void) drawQuad: (Position) position;

@end