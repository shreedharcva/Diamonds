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

- (void) spawnAt: (GridCell) spawnCell
{
    if ([grid isCellEmpty: spawnCell])
    {
        droppablePair = [grid put: Diamond at: spawnCell];    
    }
    else
    {
        droppablePair = nil;
    }    
}

- (void) spawn
{
    [self spawnAt: MakeCell(grid.width / 2, grid.height - 1)];
}
 
- (Droppable*) droppablePair
{
    return droppablePair;
}

- (void) moveRight
{
    [droppablePair moveRightOn: grid];
}

- (void) moveLeft
{
    [droppablePair moveLeftOn: grid];
}

- (void) update
{
    [self.grid updateWithGravity: gravity];
    if ([self droppablePair].state == Stopped)
    {
        [self spawn];
    }
}

@end
