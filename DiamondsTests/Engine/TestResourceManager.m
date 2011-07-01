//
//  TestResourceManager.m
//  Diamonds

#import "TestResourceManager.h"

#import "ResourceManager.h"
#import "MockTexture.h"

@implementation MockResourceManager
{
    MockTexture* lastTextureLoaded;
}

- (Texture*) loadTexture:(NSString *)name
{
    Texture* texture = [super loadTexture: name];
    lastTextureLoaded = (MockTexture*) texture;
    return texture;
}

- (void) setTextureFactory: (TextureFactory*) newFactory
{
    textureFactory = newFactory;    
}

- (MockTexture*) lastTextureLoaded
{
    return lastTextureLoaded;
}

@end


@implementation TestResourceManager

- (void) setUp
{
    [super setUp];

    manager = [MockResourceManager new];
    [manager setTextureFactory: [MockTextureFactory new]];
}

- (void) testResourceManagerLoadsATextureWithTheCorrectName
{
    [manager loadTexture: @"test"];    
    assertEqualObjects(@"test", [manager lastTextureLoaded].name);
}

- (void) testResourceManagerLoadsATextureWithADifferentName
{
    [manager loadTexture: @"test2"];    
    assertEqualObjects(@"test2", [manager lastTextureLoaded].name);
}

- (void) testResourceManagerContainesOneTextureAfterATextureIsLoaded
{
    [manager loadTexture: @"test2"];        
    assertEquals(1, [manager numberOfTextures]);
}

- (void) testResourceManagerLoadReturnesTheSameTextureWhenTwoLoadsAreRequestedWithTheSameName
{
    Texture* texture1 = [manager loadTexture: @"test"];
    Texture* texture2 = [manager loadTexture: @"test"];
    
    assertEqualObjects(texture1, texture2);
}

- (void) testResourceManagerCallsLoadOnANewTexture
{
    [manager loadTexture: @"test"];
    assertTrue([manager lastTextureLoaded].loadWasCalled);
}

@end