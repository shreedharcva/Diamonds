//
//  Droppable.m
//  Diamonds

#import "Droppable.h"

#import "Grid.h"

GridCell movementMap[4] = 
{
    { -1,  0 },      // left
    {  1,  0 },      // right
    {  0,  1 },      // up
    {  0, -1 },      // down
};

@implementation Droppable
{
    int width;
    int height;
    
@protected
    Grid* __weak grid;
    
    GridCell cell;
    DroppableState state;
    
@private
    Droppable* __weak parent;
}

@synthesize grid;

@synthesize width;
@synthesize height;

@synthesize cell;
@synthesize state;
@synthesize cellHeight;

@synthesize parent;

- (id) initWithGrid: (Grid*) grid_ at: (GridCell) cell_ width: (int) width_ height: (int) height_
{
    self = [super init];
    if (self == nil)
    {
        return nil;
    }

    width = width_;
    height = height_;

    grid = grid_;
    
    cell = cell_;
    
    state = Stopped;    
    cellHeight = 0.0f;
    
    return self;    
}

- (id) initAt: (GridCell) cell_ width: (int) width_ height: (int) height_;
{
    return [self initWithGrid: nil at: cell_ width: width_ height: height_]; 
}

- (void) setCell: (GridCell) cell_
{
    cell = cell_;
}

- (void) setWidth: (int) width_
{
    width = width_;
}

- (void) setHeight: (int) height_
{
    height = height_;
}

- (void) setState: (DroppableState) state_
{
    state = state_;
}

- (void) detachFromParent
{
    cell.column += self.parent.cell.column;
    cell.row += self.parent.cell.row;
    
    self.parent = nil;
}

- (bool) contains: (GridCell) cell_
{
    GridCell droppableCell = self.cell;
    return 
        cell_.row >= droppableCell.row && cell_.column >= droppableCell.column &&
        cell_.row < droppableCell.row + self.height && cell_.column < droppableCell.column + self.width;
}


- (bool) canMove: (Direction) direction by: (int) cells
{
    GridCell newCell = self.cell;
    GridCell movement = movementMap[direction];
    movement.row *= cells;
    movement.column *= cells;
    
    MoveCell(&newCell, movement);
    
    return [grid isAreaEmptyAt: newCell width: self.width height: self.height ignore: self];        
}

- (bool) canMove: (Direction) direction
{
    GridCell newCell = self.cell;
    MoveCell(&newCell, movementMap[direction]);
    
    return [grid isAreaEmptyAt: newCell width: self.width height: self.height ignore: self];    
}

- (void) moveBy: (GridCell) delta
{
    MoveCell(&cell, delta);
}

- (void) move: (Direction) direction
{
    if ([self canMove: direction])
    {
        [self moveBy: movementMap[direction]];
    }
}

- (void) moveRight
{
    [self move: Right];
}

- (void) moveLeft
{
    [self move: Left];
}

- (void) updateWithGravity: (float) gravity
{
    if (state == Falling)
    {
        cellHeight -= gravity;
        
        if (cellHeight < 0.00f)
        {
            int numberOfCells = -floor(cellHeight);
            cellHeight += numberOfCells;

            for (int i = 0; i < numberOfCells; ++i)
            {
                if (![self canMove: Down])
                {                        
                    state = Stopped;
                    cellHeight = 0.00f;

                    break;                        
                }
                
                cell.row -= 1;
            }
            
            if (cellHeight <= 0.00f && ![self canMove: Down])
            {
                state = Stopped;
                cellHeight = 0.00f;                
            }
        }
    }    
    else
    if (state == Stopped)
    {
        if ([self canMove: Down])
        {
            cell.row -= 1;
            
            cellHeight = 1.00f - gravity;
            if (cellHeight > 0.0)
            {
                state = Falling;
            }
        }
    }
}

- (BigGem*) formBigGem
{
    return nil;
}

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info
{
}

- (GridCell) relativeCell
{
    return cell;
}

- (GridCell) cell
{
    GridCell absoluteCell = cell;
    GridCell parentCell = parent.cell;
    
    absoluteCell.row += parentCell.row;
    absoluteCell.column += parentCell.column;
    
    return absoluteCell;
}

- (float) cellHeight
{
    return cellHeight + parent.cellHeight;
}

- (void) setCellHeight: (float) height_
{
    cellHeight = height_;
}

@end
