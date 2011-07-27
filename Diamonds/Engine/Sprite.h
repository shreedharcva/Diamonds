//
//  Sprite.h
//  Diamonds

@class SpriteBatch;
@class Texture;
@class ResourceManager;

typedef CGPoint CGVector;

CGVector CGVectorMake(float x, float y);

@interface Sprite : NSObject 

@property (readonly) CGSize size;
@property (readonly) CGPoint position;

- (id) initWithTexture: (Texture*) texture;

- (void) setSourceRectangle: (CGRect) rect;

- (void) moveTo: (CGPoint) newPosition;
- (void) moveBy: (CGVector) speed;

- (void) resizeTo: (CGSize) size;

- (void) drawIn: (SpriteBatch*) batch;

@end