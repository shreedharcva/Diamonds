//
//  GridController.m
//  Diamonds

#import "GridController.h"
#import "Grid.h"
#import "Gem.h"
#import "DroppablePair.h"

@interface Gem (testing)
- (Sprite*) sprite;
@end

@implementation GridController
{
    Grid* grid;
    float gravity;
}

@synthesize grid;
@synthesize droppablePair;

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
        GemType gems[2];    
        gems[0] = Diamond;
        gems[1] = Ruby;
        
        // TODO: create a DroppableFactory class to hide the resource manager        
        droppablePair = [[DroppablePair alloc] initWithGrid: self.grid at: spawnCell with: gems];
        [grid put: droppablePair];
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
 
- (DroppablePair*) droppablePair
{
    return droppablePair;
}

- (void) moveRight
{
    [droppablePair moveRight];
}

- (void) moveLeft
{
    [droppablePair moveLeft];
}

- (void) rotateLeft
{
    [droppablePair rotateLeft];    
}

- (void) rotateRight
{
    [droppablePair rotateRight];    
}

- (void) update
{
    [self.grid updateWithGravity: gravity];
    if ([self droppablePair].state == Stopped)
    {
        [[self droppablePair] releaseOn: self.grid];
        [self spawn];
    }
}

@end

