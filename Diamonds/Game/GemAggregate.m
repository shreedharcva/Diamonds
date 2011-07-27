//
//  GemAggregate.m
//  Diamonds


#import "GemAggregate.h"

#import "Grid.h"

@implementation GemAggregate
{
    NSMutableArray* droppables;    
}

- (id) initWithGrid: (Grid*) grid_ at: (GridCell) cell_ width: (int) width_ height: (int) height_;
{
    self = [super initWithGrid: grid_ at: cell_ width: width_ height: height_];
    if (self == nil)
        return nil;
    
    droppables = [NSMutableArray arrayWithCapacity: self.width * self.height];
    
    return self;    
}

- (bool) isCellInBounds: (GridCell) cell_
{
    return 
    cell_.column >= 0 && cell_.column < self.width &&
    cell_.row >= 0 && cell_.row < self.height;
}

- (bool) isCellEmpty: (GridCell) cell_
{
    for (Droppable* droppable in droppables)
    {
        if (
            droppable.relativeCell.row == cell_.row && 
            droppable.relativeCell.column == cell_.column)
        {
            return false;
        }
    }
    
    return true;
}

- (bool) isDroppableValid: (Droppable*) droppable
{
    return 
    [self isCellEmpty: droppable.relativeCell] &&
    [self isCellInBounds: droppable.relativeCell];
    
}

- (void) add: (Droppable*) droppable
{
    if (![self isDroppableValid: droppable])
    {
        @throw [NSException exceptionWithName:@"GemAggregate" reason: @"Aggregate cell is not empty" userInfo: nil];        
    }
    
    droppable.parent = self;
    [droppables addObject: droppable];    
}

- (Gem*) gem: (int) index
{
    return (Gem*) [droppables objectAtIndex: index];
}

- (void) releaseOnGrid
{
    Grid* grid_ = self.grid;
    
    [grid_ remove: self];
    
    for (Droppable* droppable in droppables)
    {
        [droppable detachFromParent];
        
        [grid_ put: droppable];
    }
}

@end

@interface Droppable (private)

- (void) setWidth: (int) width_;
- (void) setHeight: (int) height_;

@end

@implementation BigGem 

- (id) initWithType: (GemType) gemType at: (GridCell) cell_ grid: (Grid*) grid_ width: (int) width_ height: (int) height_
{
    self = [super initWithType: gemType at: cell_ grid: grid_];
    if (self == nil)
        return nil;
    
    [self setWidth: width_];
    [self setHeight: height_];
    
    return self;
}

- (void) placeInGrid
{
    for (int j = 0; j < self.height; ++j)
    {
        for (int i = 0; i < self.height; ++i)
        {
            GridCell gemCell = MakeCell(self.cell.column + i, self.cell.row + j);
            [self.grid remove: [self.grid get: gemCell]];            
        }
    }
    
    [self.grid put: self];
}

@end
