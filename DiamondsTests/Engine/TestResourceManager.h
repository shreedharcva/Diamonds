//
//  TestResourceManager.h
//  Diamonds

#import "Testing.h"

#import "ResourceManager.h"
#import "MockTexture.h"

@class MockTexture;

@interface MockResourceManager : ResourceManager 

- (void) setTextureFactory: (TextureFactory*) newFactory;
- (MockTexture*) lastTextureLoaded;

@end

@interface TestResourceManager : TestCase
{
    MockResourceManager* manager;
}

@end