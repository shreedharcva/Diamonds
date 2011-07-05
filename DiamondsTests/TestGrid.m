//
//  TestGrid.m
//  Diamonds

#import "TestGrid.h"

#import "Grid.h"

@interface TestGrid : TestCase 
@end

@implementation TestGrid
                    
- (void) setUp
{
    [super setUp];
}

- (void) testGridIsEmptyWhenItsCrated
{
    Grid* grid = [Grid new];
    assertTrue([grid isEmpty]);
}

- (void) testGridIsNotEmptyWhenAGemIsPut
{
    Grid* grid = [Grid new];
    [grid put: Diamond at: MakePosition(0, 0)];
    
    assertFalse([grid isEmpty]);
}

- (void) testGridReturnsTheCorrectGemTypeAtThePositionWhereAGemWasPut
{
    Grid* grid = [Grid new];
    [grid put: Diamond at: MakePosition(0, 0)];
    
    Gem* gem = [grid get: MakePosition(0, 0)];
    assertEquals(Diamond, gem.type);
}

- (void) testGridReturnsAGemWithTheCorrectPosition
{
    Grid* grid = [Grid new];
    [grid put: Diamond at: MakePosition(1, 2)];
    
    Gem* gem = [grid get: MakePosition(1, 2)];
    
    assertEquals(1, gem.position.column);
    assertEquals(2, gem.position.row);
}

@end

