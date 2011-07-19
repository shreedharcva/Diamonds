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
- (void) setCellHeight: (float) height;
@end

@implementation TestGemBase

- (Gem*) makeGem: (GemType) type
{
    return [self makeGem: type at: MakeCell(0, 0)];
}

- (Gem*) makeGem: (GemType) type at: (GridPosition) position
{
    ResourceManager* resourceManager = [ResourceManager new];    
    gem = [[Gem alloc] initWithType: type at: position resources: resourceManager];    
    return gem;
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

- (void) testGemHasNoParentsWhenItsDetached
{
    Gem* parent = [self makeGem: Diamond at: MakeCell(1, 1)];
    Gem* child = [self makeGem: Diamond at: MakeCell(1, 1)];
    
    child.parent = parent;
    [child detachFromParent];
    
    assertNil(child.parent);    
}

- (void) testGemCellIsUpdatedWhenGemIsDetachedFromParent
{
    Gem* parent = [self makeGem: Diamond at: MakeCell(1, 1)];
    Gem* child = [self makeGem: Diamond at: MakeCell(1, 1)];
    
    child.parent = parent;
    [child detachFromParent];
    
    assertEquals(MakeCell(2, 2), child.cell);
}

@end

@interface GemAggregate (testing)
- (void) setCellHeight: (float) height_;
@end


@interface TestGemAggregateBase : TestGemBase 
{
    GemAggregate* aggregate;
}
@end

@implementation TestGemAggregateBase

- (void) setUp
{
    aggregate = [[GemAggregate alloc] initAt: MakeCell(1, 1) width: 2 height: 2];
}

@end

@interface TestGemAggregate : TestGemAggregateBase
@end

@implementation TestGemAggregate

- (void) testGemAggregateContainsOneGemWhenAGemIsAdded
{
    [aggregate add: [self makeGem: Diamond at: MakeCell(0, 0)]];

    assertEquals(Diamond, [aggregate gem: 0].type);
}

- (void) testGemAggregateContainsTwoGemsWhenTwoGemsAreAdded
{
    [aggregate add: [self makeGem: Diamond at: MakeCell(0, 0)]];
    [aggregate add: [self makeGem: Ruby at: MakeCell(0, 1)]];
    
    assertEquals(Diamond, [aggregate gem: 0].type);
    assertEquals(Ruby, [aggregate gem: 1].type);
}

- (void) testGemAggregateContainsAGemWithTheAggregateAsParent
{
    [aggregate add: [self makeGem: Ruby at: MakeCell(0, 1)]];
    
    assertEquals(aggregate, [aggregate gem: 0].parent);
}

- (void) testGemAggregateThrowsExceptionIfAGemIsAddedOnTopOfAnotherGem
{
    assertThrows(
    {
        [aggregate add: [self makeGem: Ruby at: MakeCell(0, 1)]];
        [aggregate add: [self makeGem: Ruby at: MakeCell(0, 1)]];
    });
}

- (void) testGemAggregateThrowsExceptionIfAGemIsAddedOutOfBounds
{
    assertThrows(
    {
        [aggregate add: [self makeGem: Ruby at: MakeCell(5, 5)]];
    });
}

- (void) testGemAggregateContainsAGemAtTheCorrectAbsolutePosition
{
    [aggregate add: [self makeGem: Ruby at: MakeCell(1, 1)]];
    
    assertEquals(MakeCell(2, 2), [aggregate gem: 0].cell);
}

- (void) testGemAggregateHeightOverridesGemHeight
{
    [aggregate add: [self makeGem: Ruby at: MakeCell(1, 1)]];
    [aggregate setCellHeight: 0.5f];
    
    assertAlmostEquals(0.5f, [aggregate gem: 0].cellHeight);
}

- (void) testGemAggregateDrawsSpritesInTheCorrectPositionWhenAggregateHasHeightDifferentThanZero
{
    MockSpriteBatch* batch = [MockSpriteBatch new];
    
    GridPresentationInfo info;
    info.cellSize = CGSizeMake(32, 32);
    info.heightInCells = 4;

    [aggregate add: [self makeGem: Ruby at: MakeCell(0, 0)]];
    [aggregate setCellHeight: 0.5f];

    [batch begin];
    [[aggregate gem: 0] drawIn: batch info: info];
    [batch end];    

    assertAlmostEquals(48.0f, [batch lastSprite].position.y);
}

@end

@interface TestGemAggregateInGrid : TestGemAggregateBase
@end

@implementation TestGemAggregateInGrid
{
    Grid* grid;
}

- (void) setUp
{
    [super setUp];
    
    grid = [[Grid alloc] initWithResources: nil width: 8 height: 14];
}

- (void) testGemAggregateIsAddedToTheGrid
{
    [grid put: aggregate];
  
    assertIsKindOfClass(GemAggregate, [grid get: aggregate.cell]);
}

- (void) testGemAggregateCoversAllItsCellsInTheGrid
{
    [grid put: aggregate];
    
    GridCell cell = aggregate.cell;
    cell.row += 1;
    cell.column += 1;
    
    assertIsKindOfClass(GemAggregate, [grid get: cell]);
}

- (void) testGemAggregateReleasesItsGemsOnTheGrid
{
    [aggregate add: [self makeGem: Ruby at: MakeCell(0, 0)]];
    [aggregate add: [self makeGem: Ruby at: MakeCell(0, 1)]];

    [grid put: aggregate];    
    [aggregate releaseOn: grid];
        
    assertIsKindOfClass(Gem, [grid get: aggregate.cell]);
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

- (void) makePairAt: (GridCell) cell
{
    MockResourceManager* resources = [MockResourceManager new];
    
    GemType gems[2];    
    gems[0] = Diamond;
    gems[1] = Ruby;
    
    pair = [[DroppablePair alloc] initAt: cell with: gems resources: resources];        
}

- (void) testDroppablePairDrawsTwoSprites
{
    [self makePairAt: MakeCell(4, 13)];

    [batch begin];
    [pair drawIn: batch info: info];
    [batch end];    

    assertEquals(2, batch.numberOfSpritesDrawn);
}

- (void) testDroppablePairDrawsTwoSpritesWithTheCorrectTextures
{
    [self makePairAt: MakeCell(4, 13)];
    
    [batch begin];
    [pair drawIn: batch info: info];
    [batch end];    
    
    assertEqualObjects(@"diamond", [[batch.sprites objectAtIndex: 0] texture].name);
    assertEqualObjects(@"ruby", [[batch.sprites objectAtIndex: 1] texture].name);
}

@end