//
//  TestGem.m
//  Diamonds

#import "TestGem.h"

#import "Texture.h"
#import "ResourceManager.h"
#import "Grid.h"

#import "MockSpriteBatch.h"
#import "MockResourceManager.h"
#import "MockTexture.h"

@interface Gem (Testing)
@end

@implementation Gem (Testing)

- (void) setCellHeight: (float) height
{
    cellHeight = height;
}

@end

@implementation TestGemBase

- (void) makeGem: (GemType) type
{
    [self makeGem: type at: MakeCell(0, 0)];
}

- (void) makeGem: (GemType) type at: (GridPosition) position
{
    ResourceManager* resourceManager = [ResourceManager new];    
    gem = [[Gem alloc] initWithType: type at: position resources: resourceManager];    
}

@end

@interface TestGem : TestGemBase 
@end

@implementation TestGem

- (void) testGemSizeIs1x1
{
    [self makeGem: Diamond];
    
    assertEquals(1, gem.width);
    assertEquals(1, gem.height);    
}

@end

@interface TestGemDrawingBase : TestGemBase 
{
    MockSpriteBatch* batch;    
    GridPresentationInfo info;
}
@end

@implementation TestGemDrawingBase

- (void) setUp
{
    [super setUp];
    
    batch = [MockSpriteBatch new];
    
    info.cellSize = CGSizeMake(32, 32);
    info.heightInCells = 1;
}

@end

@interface TestGemDrawing: TestGemDrawingBase
@end

@implementation TestGemDrawing

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

- (void) testGemDrawsASpriteAtTheCorrectPositionWhenCellHeightIs50percent
{
    [self makeGem: Ruby];  

    [gem setCellHeight: 0.50f];
    [self drawGem];
    
    assertAlmostEquals(info.origin.y - 0.50f * info.cellSize.height, [batch lastSprite].position.y);
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


@interface TestDroppablePairDrawing : TestGemDrawingBase 
@end

@implementation TestDroppablePairDrawing
{
    DroppablePair* pair;
}

- (void) testDroppablePairDrawsTwoSprites
{
    MockResourceManager* resources = [MockResourceManager new];

    GemType gems[2];    
    gems[0] = Diamond;
    gems[1] = Ruby;
    
    pair = [[DroppablePair alloc] initAt: MakeCell(4, 13) with: gems resources: resources];    

    [batch begin];
    [pair drawIn: batch info: info];
    [batch end];    

    assertEquals(2, batch.numberOfSpritesDrawn);
}

- (void) testDroppablePairDrawsTwoSpritesWithTheCorrectTextures
{
    MockResourceManager* resources = [MockResourceManager new];
    
    GemType gems[2];    
    gems[0] = Diamond;
    gems[1] = Ruby;
    
    pair = [[DroppablePair alloc] initAt: MakeCell(4, 13) with: gems resources: resources];    
    
    [batch begin];
    [pair drawIn: batch info: info];
    [batch end];    
    
    assertEqualObjects(@"diamond", [[batch.sprites objectAtIndex: 0] texture].name);
    assertEqualObjects(@"ruby", [[batch.sprites objectAtIndex: 1] texture].name);
}

@end