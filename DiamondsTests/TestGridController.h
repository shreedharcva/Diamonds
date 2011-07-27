//
//  TestGridController.h
//  Diamonds

#import "Testing.h"

@class Grid;
@class GridController;

@interface TestGridControllerBase : TestCase 
{
    Grid* grid;
    GridController* controller;
}

@end