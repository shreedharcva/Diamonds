//
//  GridController.m
//  Diamonds

#import "GridController.h"
#import "Grid.h"
#import "Gem.h"

@implementation GridController
{
    Grid* grid;
    float gravity;
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

- (void) setGravity: (float) newGravity
{
    gravity = newGravity;
}

- (void) spawn
{
    GridCell spawnCell = MakeCell(grid.width / 2, grid.height - 1); 
    if ([grid isCellEmpty: spawnCell])
    {
        controlledGem = [grid put: Diamond at: MakeCell(grid.width / 2, grid.height - 1)];    
    }
    else
    {
        controlledGem = nil;
    }
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
    [self.grid updateWithGravity: gravity];
    if (controlledGem.state == Stopped)
    {
        [self spawn];
    }
}

@end

