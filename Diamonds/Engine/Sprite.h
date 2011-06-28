//
//  Sprite.h
//  Diamonds


@class ShaderProgram;
@class Texture;

typedef struct Position
{
    float x;
    float y;
} 
Position;

@interface Sprite : NSObject 
{
    ShaderProgram* shaderProgram;
    Texture* textureObject;
}

@property (nonatomic, retain) ShaderProgram* shaderProgram;
@property (nonatomic, retain) Texture* textureObject;

- (void) moveTo: (Position) position;
- (void) draw;

@end