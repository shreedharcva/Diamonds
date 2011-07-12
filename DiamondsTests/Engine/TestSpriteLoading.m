//
//  TestSpriteLoading.m
//  Diamonds

#import "TestResourceManager.h"
#import "Sprite.h"

#import "MockTexture.h"
#import "MockResourceManager.h"

@interface TestSpriteLoading : TestCase 
@end

// Fran: consider removing these tests

@implementation TestSpriteLoading
{
    MockResourceManager* manager;
}

- (void) setUp
{
    manager = [MockResourceManager new];
    [manager setTextureFactory: [MockTextureFactory new]];

    [super setUp];
}

- (void) testTextureIsLoadedWhenASpriteIsCreated
{
    [[Sprite alloc] initWithTexture: [manager loadTexture: @"test"]]; 

    assertTrue([manager lastTexture].loadWasCalled);
}

- (void) testOneTextureIsLoadedWhenTwoSpritesAreCreatedWithTheSameTexture
{    
    [[Sprite alloc] initWithTexture: [manager loadTexture: @"test"]]; 
    [[Sprite alloc] initWithTexture: [manager loadTexture: @"test"]]; 
    
    assertEquals(1, [manager numberOfTextures]);
}

- (void) testTwoTexturesAreLoadedWhenTwoSpritesAreCreatedWithDifferentTexture
{    
    [[Sprite alloc] initWithTexture: [manager loadTexture: @"test"]]; 
    [[Sprite alloc] initWithTexture: [manager loadTexture: @"test2"]]; 
    
    assertEquals(2, [manager numberOfTextures]);
}


@end
