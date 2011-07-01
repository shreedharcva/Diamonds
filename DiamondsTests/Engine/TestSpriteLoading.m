//
//  TestSpriteLoading.m
//  Diamonds

#import "TestResourceManager.h"
#import "Sprite.h"
        
@interface TestSpriteLoading : TestCase 
@end

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
    [[Sprite alloc] initWithTextureName: @"test" from: manager]; 

    assertTrue([manager lastTexture].loadWasCalled);
}

- (void) testOneTextureIsLoadedWhenTwoSpritesAreCreatedWithTheSameTexture
{    
    [[Sprite alloc] initWithTextureName: @"test" from: manager]; 
    [[Sprite alloc] initWithTextureName: @"test" from: manager]; 
    
    assertEquals(1, [manager numberOfTextures]);
}

- (void) testTwoTexturesAreLoadedWhenTwoSpritesAreCreatedWithDifferentTexture
{    
    [[Sprite alloc] initWithTextureName: @"test" from: manager]; 
    [[Sprite alloc] initWithTextureName: @"test2" from: manager]; 
    
    assertEquals(2, [manager numberOfTextures]);
}


@end
