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

GridPosition MakePosition(int column, int row)
{
    return MakeCell(column, row);
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

- (id) initWithResources: (ResourceManager*) resourceManager width: (int) gridWidth height: (int) gridHeight
{
    self = [super init];
    if (self == nil)
        return nil;
    
    resources = resourceManager;

    width = gridWidth;
    height = gridHeight;

    droppables = [NSMutableSet new];
    
    return self;
}

- (bool) isEmpty
{
    return [droppables count] == 0;
}

- (bool) isCellEmpty: (GridCell) cell
{
    return [self get: cell] == Nil;
}

- (bool) isCellValid: (GridCell) cell
{
    if (cell.column < 0 || cell.column >= self.width)
        return false;
    if (cell.row < 0)
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
    Gem* gem = [[Gem alloc] initWithType: type at: cell resources: resources];
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
        [droppable updateWithGravity: gravity onGrid: self];
    }    
}

@end

@implementation GridDrawer
{
    GridPresentationInfo info;
    Grid* grid;
    
    Sprite* backgroundSprite;
}

- (id) initWithGrid: (Grid*) gridToDraw info: (GridPresentationInfo) presentationInfo
{
    self = [super init];
    if (self == nil)
    {
        return nil;
    }
    
    grid = gridToDraw;
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