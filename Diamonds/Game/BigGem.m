//
//  BigGem.m
//  Diamonds

#import "BigGem.h"
#import "Grid.h"

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

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info
{
}

@end
