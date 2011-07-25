//
//  Grid.m
//  Diamonds

#import "Grid.h"
#import "Gem.h"

#import "Sprite.h"

GridCell MakeCell(int column, int row)
{
    GridCell cell = { column, row };
    return cell;    
}

void MoveCell(GridCell* cell, GridCell delta)
{    
    cell->column += delta.column;
    cell->row += delta.row;
}

bool CellIsEqualToCell(GridCell left, GridCell right)
{
    return left.row == right.row && left.column == right.column;    
}

@implementation Grid
{
    ResourceManager* resources;

    int width;
    int height;
    
    NSMutableSet* droppables;
}

@synthesize width;
@synthesize height;

@synthesize resources;

- (id) initWithResources: (ResourceManager*) resourceManager width: (int) width_ height: (int) height_
{
    self = [super init];
    if (self == nil)
        return nil;
    
    resources = resourceManager;

    width = width_;
    height = height_;

    droppables = [NSMutableSet new];
    
    return self;
}

- (bool) isEmpty
{
    return [droppables count] == 0;
}

- (bool) isAreaEmptyAt: (GridCell) cell width: (int) width_ height: (int) height_ ignore: (Droppable*) ignore
{
    for (int i = cell.column; i < cell.column + width_; ++i)
    {
        for (int j = cell.row; j < cell.row + height_; ++j)
        {
            GridCell cellToTest = MakeCell(i, j);
            if (!
                [self isCellValid: cellToTest])
            {
                return false;
            }
            
            Droppable* droppable = [self get: cellToTest];
            if (ignore != nil && droppable == ignore)
            {
                continue;
            }

            if (droppable != nil)
            {
                return false;
            }
        }
    }
    
    return true;    
}

- (bool) isAreaEmptyAt: (GridCell) cell width: (int) width_ height: (int) height_
{
    return [self isAreaEmptyAt: cell width: width_ height: height_ ignore: nil];
}

- (bool) isCellEmpty: (GridCell) cell
{
    return [self get: cell] == Nil;
}

- (bool) isCellValid: (GridCell) cell
{
    if (CellIsEqualToCell(cell, self.spawnCell))
        return true;
    
    if (cell.column < 0 || cell.column >= self.width)
        return false;
    if (cell.row < 0 || cell.row >= self.height)
        return false;
    
    return true;
}

- (NSArray*) droppables
{
    return [droppables allObjects];
}

- (Droppable*) put: (Droppable*) droppable
{
    if (![self isCellEmpty: droppable.cell])
    {
        @throw [NSException exceptionWithName:@"Grid" reason: @"Grid cell is not empty" userInfo: nil];
    }

    [droppables addObject: droppable];   
    return droppable;
}

- (Gem*) put: (GemType) type at: (GridCell) cell
{
    Gem* gem = [[Gem alloc] initWithType: type at: cell grid: self];
    [self put: gem];
    return gem;
}

- (Droppable*) get: (GridCell) cell
{
    for (Droppable* droppable in droppables)
    {
        if ([droppable contains: cell])
        {
            return droppable;
        }
    }
    
    return nil;
}

- (void) remove: (Droppable*) droppable
{
    [droppables removeObject: droppable];
}

- (void) updateWithGravity: (float) gravity
{
    for (Droppable* droppable in droppables)
    {
        [droppable updateWithGravity: gravity];
    }    
}

- (GridCell) spawnCell
{
    return MakeCell(self.width / 2, self.height);    
}

@end

@implementation GridDrawer
{
    GridPresentationInfo info;
    Grid* grid;
    
    Sprite* backgroundSprite;
}

- (id) initWithGrid: (Grid*) grid_ info: (GridPresentationInfo) presentationInfo
{
    self = [super init];
    if (self == nil)
    {
        return nil;
    }
    
    grid = grid_;
    info = presentationInfo;
    
    return self;
}

- (void) setBackground: (Sprite*) background;
{
    backgroundSprite = background;
}

- (void) drawBackgroundIn: (SpriteBatch*) batch
{
    [backgroundSprite moveTo: info.origin];
    [backgroundSprite drawIn: batch];    
}

- (void) drawIn: (SpriteBatch*) batch
{
    if ([grid isEmpty])
        return;

    for (Droppable* droppable in grid.droppables)
    {
        [droppable drawIn: batch info: info];
    }
}

@end