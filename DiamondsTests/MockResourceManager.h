//
//  MockResourceManager.h
//  Diamonds

#import "ResourceManager.h"

@class MockTexture;
@class TextureFactory;
@class MockTextureFactory;

@interface MockResourceManager : ResourceManager 

- (void) setTextureFactory: (MockTextureFactory*) newFactory;
- (MockTexture*) lastTexture;

@property (readonly) MockTextureFactory* textureFactory; 

@end