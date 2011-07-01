//
//  TestResourceManager.m
//  Diamonds


#import "Testing.h"
#import "Texture.h"

@interface MockTexture : Texture
@property (readonly) bool loadWasCalled;
@end

@implementation MockTexture
@synthesize loadWasCalled;

- (void) load;
{
    loadWasCalled = true;
}

@end

@interface MockTextureFactory : TextureFactory 
@end

@implementation MockTextureFactory

- (Texture*) create: (NSString*) name
{
    return [[MockTexture alloc] initWithName: name];
}

@end

@interface ResourceManager (Testing) 

- (void) setTextureFactory: (TextureFactory*) newFactory;

@end

@implementation ResourceManager (Testing)

- (void) setTextureFactory: (TextureFactory*) newFactory
{
    textureFactory = newFactory;    
}

- (TextureFactory *) textureFactory
{
    return textureFactory;    
}

@end

@interface TestResourceManager : TestCase
{
    ResourceManager* manager;
}

@end

@implementation TestResourceManager

- (void) setUp
{
    [super setUp];

    manager = [ResourceManager new];
    [manager setTextureFactory: [MockTextureFactory new]];
}

- (void) testResourceManagerLoadsATextureWithTheCorrectName
{
    Texture* texture = [manager loadTexture: @"test"];

    assertEqualObjects(@"test", texture.name);
}

- (void) testResourceManagerLoadsATextureWithADifferentName
{
    Texture* texture = [manager loadTexture: @"test2"];
    
    assertEqualObjects(@"test2", texture.name);
}

- (void) testResourceManagerLoadReturnesTheSameTextureWhenTwoLoadsAreRequestedWithTheSameName
{
    Texture* texture1 = [manager loadTexture: @"test"];
    Texture* texture2 = [manager loadTexture: @"test"];
    
    assertEqualObjects(texture1, texture2);
}

- (void) testResourceManagerCallsLoadOnANewTexture
{
    MockTexture* texture = (MockTexture*) [manager loadTexture: @"test"];
    assertTrue(texture.loadWasCalled);
}

@end