//
//  GridController.m
//  Diamonds

#import "GridController.h"
#import "Grid.h"
#import "Gem.h"

@interface Gem (testing)
- (Sprite*) sprite;
@end

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
        GemType gems[2];    
        gems[0] = Diamond;
        gems[1] = Ruby;
        
        // TODO: create a DroppableFactory class to hide the resource manager        
        droppablePair = [[DroppablePair alloc] initAt: spawnCell with: gems resources: grid.resources];
        NSLog(@"pivot = %@", droppablePair);
        [grid put: droppablePair];
        NSLog(@"pivot = %@", droppablePair);
    }
    else
    {
        droppablePair = nil;
    }    
}

- (void) spawn
{
    [self spawnAt: MakeCell(grid.width / 2, grid.height - 1)];
    NSLog(@"pivot = %@", droppablePair);
}
 
- (DroppablePair*) droppablePair
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
    NSLog(@"pivot = %@", droppablePair);
    
    [self.grid updateWithGravity: gravity];
    if ([self droppablePair].state == Stopped)
    {
        [self spawn];
    }
}

@end

