//
//  TestGrid.m
//  Diamonds

#import "TestGrid.h"

#import "Grid.h"

@implementation TestGridBase

- (void) setUp
{
    [super setUp];
    grid = [[Grid alloc] initWithResources: nil width: 14 height: 8];
}

- (Gem*) get: (GridCell) cell
{
    Droppable* droppable = [grid get: cell];
    
    if (![droppable isKindOfClass: [Gem class]])
    {
        return nil;
    }
    
    return (Gem*) droppable;
}

@end

@interface TestGrid : TestGridBase 

@end

@implementation TestGrid

- (void) testGridIsEmptyWhenItsCrated
{
    assertTrue([grid isEmpty]);
}

- (void) testGridSizeIsCorrectWhenItsCrated
{
    assertEquals(14, grid.width);
    assertEquals(8, grid.height);
}

- (void) testGridIsNotEmptyWhenAGemIsPut
{
    [grid put: Diamond at: MakeCell(0, 0)];
    
    assertFalse([grid isEmpty]);
}

- (void) testGridReturnsTheCorrectGemTypeAtThePositionWhereAGemWasPut
{
    [grid put: Diamond at: MakeCell(0, 0)];
    
    Gem* gem = [self get: MakeCell(0, 0)];
    assertEquals(Diamond, gem.type);
}

- (void) testGridReturnsTheCorrectGemTypeAtThePositionWhenADifferentGemTypeIsPut
{
    [grid put: Ruby at: MakeCell(0, 0)];
    
    Gem* gem = [self get: MakeCell(0, 0)];
    
    assertEquals(Ruby, gem.type);
}

- (void) testGridReturnsAGemWithTheCorrectCell
{
    [grid put: Diamond at: MakeCell(1, 2)];
    
    Gem* gem = [self get: MakeCell(1, 2)];
    
    assertEquals(1, gem.cell.column);
    assertEquals(2, gem.cell.row);
}

- (void) testGridReturnsAGemWithTheCorrectCellWhenASecondGemIsPutInADifferentCell
{
    [grid put: Diamond at: MakeCell(1, 2)];
    [grid put: Diamond at: MakeCell(2, 3)];

    Gem* gem = [self get: MakeCell(2, 3)];
    
    assertEquals(2, gem.cell.column);
    assertEquals(3, gem.cell.row);
}

- (void) testGridReturnsTheFirstGemWithTheCorrectCellWhenASecondGemIsPutInADifferentCell
{
    [grid put: Diamond at: MakeCell(1, 2)];
    [grid put: Diamond at: MakeCell(2, 3)];
    
    Gem* gem = [self get: MakeCell(1, 2)];
    
    assertEquals(1, gem.cell.column);
    assertEquals(2, gem.cell.row);
}

- (void) testGridReturnsAGemWithEmptyTypeIfAnEmptyCellIsQueried
{
    [grid put: Diamond at: MakeCell(1, 2)];
    
    Gem* gem = [self get: MakeCell(2, 2)];

    assertEquals(EmptyGem, gem.type);
}

- (void) testGridThrowsAnExceptionIfAGemIsPutInANonEmptyCell
{
    [grid put: Diamond at: MakeCell(1, 2)];
    
    assertThrows(
    {
        [grid put: Diamond at: MakeCell(1, 2)];
    });
}

@end

@interface TestGemFallingInGrid : TestGrid 
@end

@implementation TestGemFallingInGrid
{
    float gravity;
}

- (void) setGravity: (float) newGravity
{
    gravity = newGravity;
}

- (void) setUp
{
    [super setUp];
    [self setGravity: 0.10f];
}

- (void) updateGrid 
{
    [grid updateWithGravity: gravity];
}

- (void) testGemInTheFirstRowStaysAtTheSamePositionAfterAGridUpdate
{
    [grid put: Diamond at: MakeCell(0, 0)];

    Gem* gem = [self get: MakeCell(0, 0)];
    
    [self updateGrid];
    
    assertEqualObjects(gem, [grid get: MakeCell(0, 0)]);
}

- (void) testGemInTheFirstRowIsInStoppedState
{
    [grid put: Diamond at: MakeCell(0, 0)];

    [self updateGrid];
    
    Gem* gem = [self get: MakeCell(0, 0)];

    assertEquals(Stopped, gem.state);    
}

- (void) testGemWithoutAGemBeneathIsInFallingState
{
    [grid put: Diamond at: MakeCell(0, 1)];

    [self updateGrid];

    Gem* gem = [self get: MakeCell(0, 0)];
    
    assertEquals(Falling, gem.state);
}

- (void) testGemWithAGemBeneathIsInStoppedState
{
    [grid put: Diamond at: MakeCell(0, 1)];
    [grid put: Diamond at: MakeCell(0, 0)];

    [self updateGrid];
    
    Gem* gem = [self get: MakeCell(0, 1)];
    
    assertEquals(Stopped, gem.state);
}

- (void) testFallingGemMovesToTheCellBeneath
{
    [grid put: Diamond at: MakeCell(0, 1)];

    [self updateGrid];
        
    assertEquals(Diamond, [self get: MakeCell(0, 0)].type);    
}

- (void) testFallingGemMovesToTheCellBeneathAtTheCorrectCellHeight
{
    [grid put: Diamond at: MakeCell(0, 1)];

    [self updateGrid];
    
    assertEquals(1.0f - gravity, [self get: MakeCell(0, 0)].cellHeight);    
}

- (void) testFallingGemIsAtZeroPercentCellHeightWhenStopped
{
    [grid put: Diamond at: MakeCell(0, 0)];

    [self updateGrid];

    assertAlmostEquals(0.0f, [self get: MakeCell(0, 0)].cellHeight);
}

- (void) testFallingGemIsChangingCellHeightAtConstantRateAfterTwoUpdates
{
    [grid put: Diamond at: MakeCell(0, 1)];
    
    [self updateGrid];
    [self updateGrid];
    
    assertAlmostEquals(0.80f, [self get: MakeCell(0, 0)].cellHeight);
}

- (void) testFallingGemGoesThroughCellsWithTheCorrectHeight
{
    
    [grid put: Diamond at: MakeCell(0, 2)];
    
    [self setGravity: 0.60f];
    [self updateGrid];
    [self updateGrid];
    
    assertAlmostEquals(0.80f, [self get: MakeCell(0, 0)].cellHeight);
}

- (void) testFallingGemComesToAStopWhenItFallsOnTheGround
{
    [grid put: Diamond at: MakeCell(0, 1)];

    [self setGravity: 0.80f];
    [self updateGrid];
    [self updateGrid];

    assertEquals(Stopped, [self get: MakeCell(0, 0)].state);
}

- (void) testFallingGemHasCellHeightUqualsToZeroWhenItStopsFallingOnTheGround
{
    [grid put: Diamond at: MakeCell(0, 1)];
    
    [self setGravity: 0.80f];
    [self updateGrid];
    [self updateGrid];
    
    assertAlmostEquals(0.0f, [self get: MakeCell(0, 0)].cellHeight);
}

- (void) testFallingGemComesToAStopIfFallsOnAnotherGem
{
    [grid put: Diamond at: MakeCell(0, 2)];
    [grid put: Diamond at: MakeCell(0, 0)];
    
    [self setGravity: 0.80f];
    [self updateGrid];
    [self updateGrid];

    assertEquals(Stopped, [self get: MakeCell(0, 1)].state);
}

@end