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

- (void) setUp
{
    [super setUp];
    
    grid = [[Grid alloc] initWithResources: nil width: 8 height: 14];
    controller = [[GridController alloc] initWithGrid: grid];
}

- (void) testGridControllerCreatesAControlledGemAtTheCorrectCellInTheGridWhenAskedToSpawn 
{
    [controller spawn];
    
    assertEquals(MakePosition(4, 13),[controller controlledGem].position);
}

- (void) testControlledGemMovesRight
{
    [controller spawn];
    [controller moveRight];
    
    assertEquals(MakePosition(5, 13),[controller controlledGem].position);
}

- (void) testControlledGemDoesntMoveRightIfTheCellIsNotEmpty
{
    [controller.grid put: Diamond at: MakePosition(5, 13)];
    
    [controller spawn];
    [controller moveRight];
    
    assertEquals(MakePosition(4, 13),[controller controlledGem].position);
}

- (void) testControlledGemMovesLeft
{
    [controller spawn];
    [controller moveLeft];
    
    assertEquals(MakePosition(3, 13),[controller controlledGem].position);
}

- (void) testControlledGemDoesntMoveLeftIfTheCellIsNotEmpty
{
    [controller.grid put: Diamond at: MakePosition(3, 13)];
    
    [controller spawn];
    [controller moveLeft];
    
    assertEquals(MakePosition(4, 13),[controller controlledGem].position);
}

- (void) testControlledGemChangesIfTheGemStopsFalling
{    
    [controller setGravity: 1.0f];
    
    Gem* gem = [controller.grid put: Diamond at: MakePosition(0, 1)];
    [controller setControlledGemTo: gem];
    assertEquals(gem, [controller controlledGem]);
    
    [controller update];
    assertTrue(gem != [controller controlledGem]);
}

@end
