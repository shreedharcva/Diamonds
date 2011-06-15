//
//  Sprite.h
//  Diamonds


@class ShaderProgram;
@class Texture;

@interface Sprite : NSObject 
{
    ShaderProgram* shaderProgram;
    Texture* textureObject;
}

@property (nonatomic, retain) ShaderProgram* shaderProgram;
@property (nonatomic, retain) Texture* textureObject;

- (void) draw;

@end