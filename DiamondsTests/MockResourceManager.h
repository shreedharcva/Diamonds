//
//  MockResourceManager.h
//  Diamonds

#import "ResourceManager.h"

@class MockTexture;
@class TextureFactory;

@interface MockResourceManager : ResourceManager 

- (void) setTextureFactory: (TextureFactory*) newFactory;
- (MockTexture*) lastTexture;

@end