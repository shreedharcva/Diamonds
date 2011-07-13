//
//  TestGem.m
//  Diamonds

#import "TestGem.h"

#import "Texture.h"
#import "ResourceManager.h"
#import "Grid.h"

#import "MockSpriteBatch.h"
#import "MockTexture.h"

@implementation TestGemBase

- (void) makeGem: (GemType) type
{
    [self makeGem: type at: MakePosition(0, 0)];
}

- (void) makeGem: (GemType) type at: (GridPosition) position
{
    ResourceManager* resourceManager = [ResourceManager new];    
    gem = [[Gem alloc] initWithType: type at: position resources: resourceManager];    
}

@end

@interface TestGemDrawing: TestGemBase
@end

@implementation TestGemDrawing
{
    MockSpriteBatch* batch;    
    GridPresentationInfo info;
}

- (void) setUp
{
    [super setUp];

    batch = [MockSpriteBatch new];
}

- (void) drawGemAt: (CGPoint) origin
{
    [batch begin];
    [gem drawIn: batch info: info];
    [batch end];    
}

- (void) drawGem
{
    [self drawGemAt: CGPointZero];
}

- (void) testGemDrawsASprite
{
    [self makeGem: Diamond];
    [self drawGem];

    assertEquals(1, [batch numberOfSpritesDrawn]);
}

- (void) testDiamondGemDrawsASpriteWithTheCorrectTextureName
{
    [self makeGem: Diamond];
    [self drawGem];
    
    assertEqualObjects(@"diamond", [batch lastSprite].texture.name);
}

- (void) testRubyGemDrawsASpriteWithTheCorrectTextureName
{
    [self makeGem: Ruby];
    [self drawGem];
    
    assertEqualObjects(@"ruby", [batch lastSprite].texture.name);    
}

- (void) testGemDrawsASpriteAtTheCorrectPosition
{
    info.origin = CGPointMake(100, 150);

    [self makeGem: Ruby];  
    [self drawGem];
    
    assertEquals(info.origin, [batch lastSprite].position);
}

- (void) testGemDrawsASpriteWithTheCorrectSize
{
    [self makeGem: Ruby];
    [self drawGem];
    
    assertEquals(CGSizeMake(32, 32), [batch lastSprite].size);
}

- (void) testGemDrawsASpriteWithTheCorrectSourceRectangle
{
    [self makeGem: Ruby];
    [self drawGem];
    
    assertEquals(CGRectMake(0, 0, 0.5, 0.125), [batch lastSprite].sourceRect);    
}

@end

