//
//  TestGridController.m
//  Diamonds

#import "TestGridController.h"
#import "Grid.h"

@interface TestGridController : TestCase 
@end

@interface GridController : NSObject

- (id) initWithGrid: (Grid*) grid;

- (void) spawn;
- (Gem*) controlledGem;

@property (readonly, nonatomic) Grid* grid;

@end

@implementation GridController
{
    Grid* grid;
    Gem* controlledGem;
}

@synthesize grid;

- (id) initWithGrid: (Grid*) theGrid
{
    self = [super init];
    if (self == nil)
    {
        return nil;
    }
    
    grid = theGrid;
    
    return self;
}

- (void) spawn
{
    controlledGem = [grid put: Ruby at: MakePosition(grid.width / 2, grid.height - 1)];    
}

- (Gem*) controlledGem
{
    return controlledGem;
}

- (void) moveRight
{
    [controlledGem moveRightOn: grid];
}

- (void) moveLeft
{
    [controlledGem moveLeftOn: grid];
}

- (void) update
{
    [self.grid updateWithGravity: 1.0f];
    if (controlledGem.state == Stopped)
    {
        controlledGem = nil;
    }
}

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
    Gem* gem = [controller.grid put: Diamond at: MakePosition(0, 1)];
    [controller setControlledGemTo: gem];
    assertEquals(gem, [controller controlledGem]);
    
    [controller update];
    assertTrue(gem != [controller controlledGem]);
}

@end
