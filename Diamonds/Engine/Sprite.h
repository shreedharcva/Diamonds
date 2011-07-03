//
//  Sprite.h
//  Diamonds

@class SpriteBatch;
@class Texture;
@class ResourceManager;

@interface Sprite : NSObject 

@property (readonly) CGSize size;

- (id) initWithTexture: (Texture*) texture;

- (void) moveTo: (CGPoint) newPosition;
- (void) resizeTo: (CGSize) size;
- (void) setSourceRectangle: (CGRect) rect;

- (void) drawIn: (SpriteBatch*) batch;

@end