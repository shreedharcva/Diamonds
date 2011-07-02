//
//  Sprite.h
//  Diamonds

@class SpriteBatch;
@class Texture;
@class ResourceManager;

@interface Sprite : NSObject 

- (id) initWithTexture: (Texture*) texture;

- (void) moveTo: (CGPoint) newPosition;
- (void) resizeTo: (CGSize) size;

- (void) drawIn: (SpriteBatch*) batch;

@end