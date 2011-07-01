//
//  Sprite.h
//  Diamonds

@class SpriteBatch;
@class ResourceManager;

@interface Sprite : NSObject 

- (id) initWithTextureName: (NSString*) name from: (ResourceManager*) resources;

- (void) moveTo: (CGPoint) newPosition;
- (void) resizeTo: (CGSize) size;

- (void) drawIn: (SpriteBatch*) batch;

@end