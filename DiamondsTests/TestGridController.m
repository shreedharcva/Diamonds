//
//  TestGridController.m
//  Diamonds

#import "TestGridController.h"
#import "GridController.h"
#import "Grid.h"
#import "Sprite.h"

@interface Gem (testing)

- (Sprite*) sprite;

@end

@interface TestGridController : TestCase 
@end

@interface GridController (test)

- (void) spawnAt: (GridCell) cell;

@end

@implementation TestGridController
{
    Grid* grid;
    GridController* controller;
}

- (void) setUp
{
    [super setUp];
    
    grid = [[Grid alloc] initWithResources: nil width: 8 height: 14];
    controller = [[GridController alloc] initWithGrid: grid];
}

- (void) testGridControllerCreatesADroppablePairAtTheCorrectCellInTheGridWhenAskedToSpawn 
{
    [controller spawn];
    
    assertEquals(MakeCell(4, 13),[controller droppablePair].cell);
}

- (void) testDroppablePairMovesRight
{
    [controller spawn];
    [controller moveRight];
    
    assertEquals(MakeCell(5, 13),[controller droppablePair].cell);
}

- (void) testDroppablePairDoesntMoveRightIfTheCellIsNotEmpty
{
    [controller.grid put: Diamond at: MakeCell(5, 13)];
    
    [controller spawn];
    [controller moveRight];
    
    assertEquals(MakeCell(4, 13),[controller droppablePair].cell);
}

- (void) testDroppablePairDoesntMoveRightIfTheCellIsOutOfTheGrid
{
    [controller spawnAt: MakeCell(grid.width - 1, 13)];
    
    [controller moveRight];
    
    assertEquals(MakeCell(grid.width - 1, 13),[controller droppablePair].cell);
}

- (void) testDroppablePairMovesLeft
{
    [controller spawn];
    [controller moveLeft];
    
    assertEquals(MakeCell(3, 13),[controller droppablePair].cell);
}

- (void) testDroppablePairDoesntMoveLeftIfTheCellIsNotEmpty
{
    [controller.grid put: Diamond at: MakeCell(3, 13)];
    
    [controller spawn];
    [controller moveLeft];
    
    assertEquals(MakeCell(4, 13), [controller droppablePair].cell);
}

- (void) testDroppablePairDoesntMoveLeftIfTheCellIsOutOfTheGrid
{
    [controller spawnAt: MakeCell(0, 13)];
    
    [controller moveLeft];
    
    assertEquals(MakeCell(0, 13),[controller droppablePair].cell);
}

- (void) testGridControllerSpawnsANewPairThatStartsFalling
{    
    [controller setGravity: 0.0f];
    
    [controller spawnAt: MakeCell(4, 13)];
    [controller update];
    
    assertEquals(Falling, [controller droppablePair].state);
}

- (void) testGridControllerSpawnsANewDroppablePairWhenTheOldOneStopsFalling
{    
    [controller setGravity: 1.0f];
    
    [controller spawnAt: MakeCell(0, 1)];
    [controller update];

    assertEquals(MakeCell(4, 13),[controller droppablePair].cell);
}

- (void) testGridControllerDoesntSpawnANewDroppablePairWhenTheMiddleColumnIsFull
{
    for (int i = 0; i < 14; ++i)
    {
        [controller.grid put: Diamond at: MakeCell(4, i)];
    }
    
    [controller spawn];
    
    assertNil([controller droppablePair]);
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
    
    pair = [[DroppablePair alloc] initAt: MakeCell(4, 12) with: gems resources: nil];    
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

- (void) testDroppablePairIsCreatedWithPivotAndBuddyAndSprites
{    
    assertNotNil([pair.pivot sprite]);
    assertNotNil([pair.buddy sprite]);
}

- (void) testDroppablePairIsCreatedWithTheCorrectCell
{
    assertEquals(MakeCell(4, 12), pair.cell);    
}

- (void) testDroppablePairCreatesTwoGemsAtTheCorrectCells
{
    assertEquals(MakeCell(4, 12), pair.pivot.cell);    
    assertEquals(MakeCell(4, 13), pair.buddy.cell);    
}

@end
