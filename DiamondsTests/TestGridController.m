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
    
    assertEquals(MakeCell(4, 13),[controller controlledGem].position);
}

- (void) testControlledGemMovesRight
{
    [controller spawn];
    [controller moveRight];
    
    assertEquals(MakeCell(5, 13),[controller controlledGem].position);
}

- (void) testControlledGemDoesntMoveRightIfTheCellIsNotEmpty
{
    [controller.grid put: Diamond at: MakeCell(5, 13)];
    
    [controller spawn];
    [controller moveRight];
    
    assertEquals(MakeCell(4, 13),[controller controlledGem].position);
}

- (void) testControlledGemDoesntMoveRightIfTheCellIsOutOfTheGrid
{
    [self setControlledGemTo: MakeCell(grid.width - 1, 13)];
    
    [controller moveRight];
    
    assertEquals(MakeCell(grid.width - 1, 13),[controller controlledGem].position);
}

- (void) testControlledGemMovesLeft
{
    [controller spawn];
    [controller moveLeft];
    
    assertEquals(MakeCell(3, 13),[controller controlledGem].position);
}

- (void) testControlledGemDoesntMoveLeftIfTheCellIsNotEmpty
{
    [controller.grid put: Diamond at: MakeCell(3, 13)];
    
    [controller spawn];
    [controller moveLeft];
    
    assertEquals(MakeCell(4, 13), [controller controlledGem].position);
}

- (void) testControlledGemDoesntMoveLeftIfTheCellIsOutOfTheGrid
{
    [self setControlledGemTo: MakeCell(0, 13)];
    
    [controller moveLeft];
    
    assertEquals(MakeCell(0, 13),[controller controlledGem].position);
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

    assertEquals(MakeCell(4, 13),[controller controlledGem].position);
}

@end
