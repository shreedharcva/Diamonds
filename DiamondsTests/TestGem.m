//
//  TestGem.m
//  Diamonds

#import "TestGem.h"

#import "Texture.h"
#import "ResourceManager.h"
#import "Grid.h"

#import "MockSpriteBatch.h"
#import "MockTexture.h"
#import "TestResourceManager.h"

@interface TestGem: TestCase 
@end

@implementation TestGem
{
    MockSpriteBatch* batch;
    Gem* gem;
}

- (void) setUp
{
    [super setUp];

    batch = [MockSpriteBatch new];
}

- (void) makeGem: (GemType) type
{
    ResourceManager* resourceManager = [ResourceManager new];    
    gem = [[Gem alloc] initWithType: type at: MakePosition(0, 0) resources: resourceManager];    
}

- (void) testGemDrawsASprite
{
    [self makeGem: Diamond];

    [batch begin];
    [gem drawIn: batch at: CGPointZero];
    [batch end];

    assertEquals(1, [batch numberOfSpritesDrawn]);
}

- (void) testDiamondGemDrawsASpriteWithTheCorrectTextureName
{
    [self makeGem: Diamond];
    
    [batch begin];
    [gem drawIn: batch at: CGPointZero];
    [batch end];
    
    assertEqualObjects(@"diamond", [batch lastSprite].texture.name);
}

- (void) testRubyGemDrawsASpriteWithTheCorrectTextureName
{
    [self makeGem: Ruby];
    
    [batch begin];
    [gem drawIn: batch at: CGPointZero];
    [batch end];
    
    assertEqualObjects(@"ruby", [batch lastSprite].texture.name);    
}

- (void) testGemDrawsASpriteAtTheCorrectPosition
{
    [self makeGem: Ruby];
    
    CGPoint position = CGPointMake(100, 150);
    
    [batch begin];
    [gem drawIn: batch at: position];
    [batch end];
    
    assertEquals(position.x, [batch lastSprite].position.x);    
    assertEquals(position.y, [batch lastSprite].position.y);    
}

@end

