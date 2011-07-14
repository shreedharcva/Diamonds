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
    [self.grid updateWithGravity: gravity];
    if (controlledGem.state == Stopped)
    {
        [self spawn];
    }
}

@end

