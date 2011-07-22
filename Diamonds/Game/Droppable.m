//
//  Droppable.m
//  Diamonds

#import "Droppable.h"

#import "Grid.h"

@implementation Droppable
{
    int width;
    int height;
    
@protected
    Grid* grid;
    
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

- (bool) canMoveRight: (Grid*) grid_
{
    GridCell newCell = self.cell;
    newCell.column += 1;

    return [grid isAreaEmptyAt: newCell width: self.width height: self.height ignore: self];
}

- (bool) canMoveLeft: (Grid*) grid_
{
    GridCell newCell = self.cell;
    newCell.column -= 1;
    
    return [grid isAreaEmptyAt: newCell width: self.width height: self.height ignore: self];
}

- (bool) canMoveDown: (Grid*) grid_
{
    GridCell newCell = self.cell;
    newCell.row -= 1;
    
    return [grid isAreaEmptyAt: newCell width: self.width height: self.height ignore: self];
}

- (void) moveRight
{
    if ([self canMoveRight: grid])
    {
        cell.column += 1;
    }
}

- (void) moveLeft
{
    if ([self canMoveLeft: grid])
    {
        cell.column -= 1;
    }
}

- (void) updateWithGravity: (float) gravity
{
    if (state == Falling)
    {
        cellHeight -= gravity;
        
        if (cellHeight < 0.00f)
        {
            cellHeight += 1.00f;
            
            if ([self canMoveDown: grid])
            {
                cell.row -= 1;
            }
            else
            {
                state = Stopped;
                cellHeight = 0.00f;
            }
        }
    }    
    else
    if (state == Stopped)
    {
        if ([self canMoveDown: grid])
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
