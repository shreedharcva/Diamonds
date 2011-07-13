//
//  TestGrid.h
//  Diamonds

#import "Testing.h"

@class Grid;

@interface TestGridBase : TestCase 
{
    Grid* grid;
}

- (void) setUp;

@end