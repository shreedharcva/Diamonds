//
//  TestGem.m
//  Diamonds

#import "TestGem.h"

#import "Texture.h"
#import "ResourceManager.h"
#import "Grid.h"
#import "GemAggregate.h"
#import "DroppablePair.h"

#import "MockSpriteBatch.h"
#import "MockResourceManager.h"
#import "MockTexture.h"

@interface GemAggregate (testing)
- (void) setCellHeight: (float) height_;
@end


@interface TestGemAggregateBase : TestGemBase 
{
    Grid* grid;
    GemAggregate* aggregate;
}
@end

@implementation TestGemAggregateBase

- (void) setUp
{
    grid = [[Grid alloc] initWithResources: nil width: 8 height: 14];

    aggregate = [[GemAggregate alloc] initWithGrid: grid at: MakeCell(1, 1) width: 2 height: 2];
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

- (void) testGemAggregateIsAddedToTheGrid
{
    [grid put: aggregate];
  
    assertIsKindOfClass(GemAggregate, [grid get: aggregate.cell]);
}

- (void) testGemAggregateCoversAllItsCellsInTheGrid
{
    [grid put: aggregate];
    
    GridCell cell = aggregate.cell;
    MoveCell(&cell, MakeCell(1, 1));
    
    assertIsKindOfClass(GemAggregate, [grid get: cell]);
}

- (void) testGemAggregateReleasesItsGemsOnTheGrid
{
    [aggregate add: [self makeGem: Ruby at: MakeCell(0, 0)]];
    [aggregate add: [self makeGem: Ruby at: MakeCell(0, 1)]];

    [grid put: aggregate];    
    [aggregate releaseOnGrid];
        
    assertIsKindOfClass(Gem, [grid get: aggregate.cell]);
}

@end