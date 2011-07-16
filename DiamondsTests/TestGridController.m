//
//  TestGridController.m
//  Diamonds

#import "TestGridController.h"
#import "GridController.h"
#import "Grid.h"

@interface TestGridController : TestCase 
@end

@interface GridController (test)
@end

@implementation GridController (test)

- (void) setControlledGemTo: (Gem*) gem
{
    controlledGem = gem;
}

@end

@implementation TestGridController
{
    Grid* grid;
    GridController* controller;
}

- (void) setControlledGemTo: (GridPosition) gridPosition
{
    [controller setControlledGemTo: [controller.grid put: Diamond at: gridPosition]];    
}

- (void) setUp
{
    [super setUp];
    
    grid = [[Grid alloc] initWithResources: nil width: 8 height: 14];
    controller = [[GridController alloc] initWithGrid: grid];
}

- (void) testGridControllerCreatesAControlledGemAtTheCorrectCellInTheGridWhenAskedToSpawn 
{
    [controller spawn];
    
    assertEquals(MakeCell(4, 13),[controller controlledGem].cell);
}

- (void) testControlledGemMovesRight
{
    [controller spawn];
    [controller moveRight];
    
    assertEquals(MakeCell(5, 13),[controller controlledGem].cell);
}

- (void) testControlledGemDoesntMoveRightIfTheCellIsNotEmpty
{
    [controller.grid put: Diamond at: MakeCell(5, 13)];
    
    [controller spawn];
    [controller moveRight];
    
    assertEquals(MakeCell(4, 13),[controller controlledGem].cell);
}

- (void) testControlledGemDoesntMoveRightIfTheCellIsOutOfTheGrid
{
    [self setControlledGemTo: MakeCell(grid.width - 1, 13)];
    
    [controller moveRight];
    
    assertEquals(MakeCell(grid.width - 1, 13),[controller controlledGem].cell);
}

- (void) testControlledGemMovesLeft
{
    [controller spawn];
    [controller moveLeft];
    
    assertEquals(MakeCell(3, 13),[controller controlledGem].cell);
}

- (void) testControlledGemDoesntMoveLeftIfTheCellIsNotEmpty
{
    [controller.grid put: Diamond at: MakeCell(3, 13)];
    
    [controller spawn];
    [controller moveLeft];
    
    assertEquals(MakeCell(4, 13), [controller controlledGem].cell);
}

- (void) testControlledGemDoesntMoveLeftIfTheCellIsOutOfTheGrid
{
    [self setControlledGemTo: MakeCell(0, 13)];
    
    [controller moveLeft];
    
    assertEquals(MakeCell(0, 13),[controller controlledGem].cell);
}

- (void) testControlledGemChangesIfTheGemStopsFalling
{    
    [controller setGravity: 1.0f];
    
    Gem* gem = [controller.grid put: Diamond at: MakeCell(0, 1)];
    [controller setControlledGemTo: gem];
    assertEquals(gem, [controller controlledGem]);
    
    [controller update];
    assertTrue(gem != [controller controlledGem]);
}

- (void) testGridControllerSpawnsANewControlledGemWhenTheOldOneStopsFalling
{    
    [controller setGravity: 1.0f];
    
    Gem* gem = [controller.grid put: Diamond at: MakeCell(0, 1)];
    [controller setControlledGemTo: gem];
    [controller update];

    assertEquals(MakeCell(4, 13),[controller controlledGem].cell);
}

- (void) testGridControllerDoesntSpawnANewControlledGemWhenTheMiddleColumnIsFull
{
    for (int i = 0; i < 14; ++i)
    {
        [controller.grid put: Diamond at: MakeCell(4, i)];
    }
    
    [controller spawn];
    
    assertNil([controller controlledGem]);
}

@end

@interface TestDroppablePair : TestCase 
@end

@implementation TestDroppablePair
{
    DroppablePair* pair;
}

- (void) setUp
{
    [super setUp];

    GemType gems[2];    
    gems[0] = Diamond;
    gems[1] = Ruby;
    
    pair = [[DroppablePair alloc] initAt: MakeCell(4, 13) with: gems resources: nil];    
}

- (void) testDroppablePairSizeIs1x2
{
    assertEquals(1, pair.width);
    assertEquals(2, pair.height);
}

- (void) testDroppablePairIsCreatedWithCorrectPivotAndBuddy
{
    assertEquals(Diamond, pair.pivot.type);
    assertEquals(Ruby, pair.buddy.type);
}

- (void) testDroppablePairIsCreatedWithTheCorrectCell
{
    assertEquals(MakeCell(4, 13), pair.cell);    
}

@end