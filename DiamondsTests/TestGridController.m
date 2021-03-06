//
//  TestGridController.m
//  Diamonds

#import "TestGridController.h"

#import "Sprite.h"

#import "GridController.h"
#import "GridController+Testing.h"
#import "Grid.h"
#import "DroppablePair.h"

#import "MockResourceManager.h"

@interface Gem (testing)

- (Sprite*) sprite;

@end

@interface GridController (test)

- (void) spawnAt: (GridCell) cell;

@end

@implementation TestGridControllerBase

- (void) setUp
{
    [super setUp];
    
    resources = [MockResourceManager new];
    
    grid = [[Grid alloc] initWithResources: resources width: 8 height: 14];
    controller = [[GridController alloc] initWithGrid: grid];
}

@end

@interface TestGridController : TestGridControllerBase 
@end

@implementation TestGridController

- (void) testGridControllerCreatesADroppablePairAtTheCorrectCellInTheGridWhenAskedToSpawn 
{
    [controller spawn];
    
    assertEquals(MakeCell(4, 13),[controller droppablePair].cell);
}

- (void) testDroppablePairMovesRight
{
    [controller spawnAt: MakeCell(1, 2)];
    [controller moveRight];
    
    assertEquals(MakeCell(2, 2),[controller droppablePair].cell);
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
    [controller spawnAt: MakeCell(1, 2)];
    [controller moveLeft];
    
    assertEquals(MakeCell(0, 2),[controller droppablePair].cell);
}

- (void) testDroppableSpawnedAtOriginDoesntMoveLeft
{
    [controller spawn];
    [controller moveLeft];
    
    assertEquals(MakeCell(4, 13),[controller droppablePair].cell);
}

- (void) testDroppableSpawnedAtOriginDoesntMoveRight
{
    [controller spawn];
    [controller moveRight];
    
    assertEquals(MakeCell(4, 13),[controller droppablePair].cell);
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

- (void) testTwoGemsAreCreatedWhereTheDroppablePairStopsFalling
{    
    [controller setGravity: 1.0f];
    
    [controller spawnAt: MakeCell(0, 1)];
    [controller update];
    
    assertIsKindOfClass(Gem, [controller.grid get: MakeCell(0, 0)]);
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

- (void) testGridControllerRotatesThePairLeft
{
    [controller spawnAt: MakeCell(2, 2)];
    [controller rotateLeft];
    
    assertEquals(HorizontalLeft, [controller droppablePair].orientation);
}

- (void) testGridControllerDoesntRotateThePairLeftIfTheLeftCellIsNotEmpty
{
    [controller spawnAt: MakeCell(2, 2)];
    [controller.grid put: Diamond at: MakeCell(1, 2)];
    [controller rotateLeft];
    
    assertEquals(VerticalUp, [controller droppablePair].orientation);
}

- (void) testGridControllerDoesntRotateAnHorizontalPairLeftIfTheCellUnderneathIsNotEmpty
{
    [controller spawnAt: MakeCell(2, 2)];
    [controller.grid put: Diamond at: MakeCell(1, 1)];
    [controller rotateLeft];
    [controller rotateLeft];
    
    assertEquals(HorizontalLeft, [controller droppablePair].orientation);
}

- (void) testGridControllerDoesntRotateAVerticalDownPairLeftIfTheCellOnTheRightIsNotEmpty
{
    [controller spawnAt: MakeCell(2, 2)];
    [controller.grid put: Diamond at: MakeCell(3, 1)];
    [controller rotateLeft];
    [controller rotateLeft];
    [controller rotateLeft];
    
    assertEquals(VerticalDown, [controller droppablePair].orientation);
}

- (void) testGridControllerDoesntRotateAnHorizontalRightPairLeftIfTheCellAboveIsNotEmpty
{
    [controller spawnAt: MakeCell(2, 2)];
    [controller.grid put: Diamond at: MakeCell(3, 3)];
    [controller rotateLeft];
    [controller rotateLeft];
    [controller rotateLeft];
    [controller rotateLeft];
    
    assertEquals(HorizontalRight, [controller droppablePair].orientation);
}

- (void) testGridControllerRotatesThePairRight
{
    [controller spawnAt: MakeCell(2, 2)];
    [controller rotateRight];
    
    assertEquals(HorizontalRight, [controller droppablePair].orientation);
}

- (void) testGridControllerDoesntRotateThePairRightIfTheCellOnTheRightIsNotEmpty
{
    [controller spawnAt: MakeCell(2, 2)];
    [controller.grid put: Diamond at: MakeCell(3, 2)];
    [controller rotateRight];
    
    assertEquals(VerticalUp, [controller droppablePair].orientation);
}

@end

@interface TestGridControllerWithDroppablePair : TestGridControllerBase 
@end

@implementation TestGridControllerWithDroppablePair

- (void) testGridControllerSpawnsANewPairWhenAVerticalDownDropPairCollidesWithTwoGemsUnderneath
{
    [controller.grid put: Diamond at: MakeCell(1, 0)];
    [controller.grid put: Diamond at: MakeCell(1, 1)];

    [controller spawnAt: MakeCell(0, 2)];

    [controller rotateRight];

    [controller setGravity: 1.0f];    
    [controller update];
    
    assertEquals(MakeCell(4, 13), controller.droppablePair.cell);
}

- (void) testDroppablePairCanMoveRightOnTheRightEdgeOfTheGrid
{
    [controller spawnAt: MakeCell(5, 2)];
    [controller rotateRight];
    [controller moveRight];

    assertEquals(MakeCell(6, 2), controller.droppablePair.cell);    
}

@end

@interface TestGridControllerWithDroppingDroppablePair : TestGridControllerBase 
@end

@implementation TestGridControllerWithDroppingDroppablePair
{
    float droppingGravity;
}

- (void) setUp
{
    [super setUp];

    droppingGravity = 10.0f;
    [DroppablePair setDroppingGravity: droppingGravity];    
}

- (DroppablePair*) getPairAtSpawn
{
    return (DroppablePair*) [controller.grid get: controller.grid.spawnCell];
}

- (void) testSpawnedPairIsNotDropping
{
    [controller spawn];
    
    assertTrue(![[self getPairAtSpawn] isDropping]);
}

- (void) testDroppedPairIsDropping
{
    [controller spawn];
    [controller drop];

    assertTrue([[self getPairAtSpawn] isDropping]);
}

- (void) testDroppedPairHasMovedByTenCellsAfterAnUpdate
{
    [controller spawn];
    [controller drop];
    [controller update];
    
    GridCell cell = controller.grid.spawnCell;
    cell.row -= 1;
    cell.row -= droppingGravity;
    
    assertEquals(cell, controller.droppablePair.cell);
}

- (void) testDroppedPairReleasesGemsOnTheBottomOfTheGridAfterTwoUpdates
{
    [controller spawn];
    [controller drop];
    
    [controller update];
    [controller update];
    
    GridCell bottomCell = controller.grid.spawnCell;
    bottomCell.row = 0;
    
    assertIsKindOfClass(Gem, [controller.grid get: bottomCell]);
}

@end



