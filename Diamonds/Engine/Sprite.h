//
//  Sprite.h
//  Diamonds


@class ShaderProgram;
@class Texture;
@class Engine;

typedef struct Position
{
    float x;
    float y;
} 
Position;

@interface Sprite : NSObject 

- (void) moveTo: (Position) position;
- (void) drawUsingEngine: (Engine*) engine;

@end