//
//  TestResourceManager.m
//  Diamonds

#import "TestResourceManager.h"
#import "MockResourceManager.h"
#import "MockTexture.h"

@implementation TestResourceManager

- (void) setUp
{
    [super setUp];

    resources = [MockResourceManager new];
    [resources setTextureFactory: [MockTextureFactory new]];
}

- (void) testResourceManagerLoadsATextureWithTheCorrectName
{
    [resources loadTexture: @"test"];    
    assertEqualObjects(@"test", [resources lastTexture].name);
}

- (void) testResourceManagerLoadsATextureWithADifferentName
{
    [resources loadTexture: @"test2"];    
    assertEqualObjects(@"test2", [resources lastTexture].name);
}

- (void) testResourceManagerContainsOneTextureAfterATextureIsLoaded
{
    [resources loadTexture: @"test2"];        
    assertEquals(1, [resources numberOfTextures]);
}

- (void) testResourceManagerLoadReturnesTheSameTextureWhenTwoLoadsAreRequestedWithTheSameName
{
    Texture* texture1 = [resources loadTexture: @"test"];
    Texture* texture2 = [resources loadTexture: @"test"];
    
    assertEqualObjects(texture1, texture2);
}

- (void) testResourceManagerCallsLoadOnANewTexture
{
    [resources loadTexture: @"test"];
    assertTrue([resources lastTexture].loadWasCalled);
}

@end