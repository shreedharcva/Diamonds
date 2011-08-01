//
//  TestGridController.h
//  Diamonds

#import "Testing.h"

@class Grid;
@class GridController;
@class MockResourceManager;

@interface TestGridControllerBase : TestCase 
{
    Grid* grid;
    GridController* controller;
    MockResourceManager* resources;
}

@end