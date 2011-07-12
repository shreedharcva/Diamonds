//
//  TestGrid.m
//  Diamonds

#import "TestGrid.h"

#import "Grid.h"

@interface TestGrid : TestCase 
@end

@implementation TestGrid
{
    Grid* grid;
}

- (void) setUp
{
    [super setUp];
    grid = [[Grid alloc] initWithResources: nil];
}

- (void) testGridIsEmptyWhenItsCrated
{
    assertTrue([grid isEmpty]);
}

- (void) testGridIsNotEmptyWhenAGemIsPut
{
    [grid put: Diamond at: MakePosition(0, 0)];
    
    assertFalse([grid isEmpty]);
}

- (void) testGridReturnsTheCorrectGemTypeAtThePositionWhereAGemWasPut
{
    [grid put: Diamond at: MakePosition(0, 0)];
    
    Gem* gem = [grid get: MakePosition(0, 0)];
    assertEquals(Diamond, gem.type);
}

- (void) testGridReturnsTheCorrectGemTypeAtThePositionWhenADifferentGemTypeIsPut
{
    [grid put: Ruby at: MakePosition(0, 0)];
    
    Gem* gem = [grid get: MakePosition(0, 0)];
    
    assertEquals(Ruby, gem.type);
}

- (void) testGridReturnsAGemWithTheCorrectPosition
{
    [grid put: Diamond at: MakePosition(1, 2)];
    
    Gem* gem = [grid get: MakePosition(1, 2)];
    
    assertEquals(1, gem.position.column);
    assertEquals(2, gem.position.row);
}

- (void) testGridReturnsAGemWithTheCorrectPositionWhenASecondGemIsPutInADifferentPosition
{
    [grid put: Diamond at: MakePosition(1, 2)];
    [grid put: Diamond at: MakePosition(2, 3)];

    Gem* gem = [grid get: MakePosition(2, 3)];
    
    assertEquals(2, gem.position.column);
    assertEquals(3, gem.position.row);
}

- (void) testGridReturnsTheFirstGemWithTheCorrectPositionWhenASecondGemIsPutInADifferentPosition
{
    [grid put: Diamond at: MakePosition(1, 2)];
    [grid put: Diamond at: MakePosition(2, 3)];
    
    Gem* gem = [grid get: MakePosition(1, 2)];
    
    assertEquals(1, gem.position.column);
    assertEquals(2, gem.position.row);
}

- (void) testGridReturnsAGemWithEmptyTypeIfAnEmptyPositionIsQueried
{
    [grid put: Diamond at: MakePosition(1, 2)];
    
    Gem* gem = [grid get: MakePosition(2, 2)];

    assertEquals(EmptyGem, gem.type);
}

- (void) testGridThrowsAnExceptionIfAGemIsPutInANonEmptyPosition
{
    [grid put: Diamond at: MakePosition(1, 2)];
    
    assertThrows(
    {
        [grid put: Diamond at: MakePosition(1, 2)];
    });
}

@end

