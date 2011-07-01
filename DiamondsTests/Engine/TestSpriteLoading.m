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

    assertTrue([manager lastTextureLoaded].loadWasCalled);
}

@end
