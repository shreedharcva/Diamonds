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
    
    NSMutableSet* gems;
}

@synthesize width;
@synthesize height;

- (id) initWithResources: (ResourceManager*) resourceManager width: (int) gridWidth height: (int) gridHeight
{
    self = [super init];
    if (self == nil)
        return nil;
    
    resources = resourceManager;

    width = gridWidth;
    height = gridHeight;

    gems = [NSMutableSet new];
    
    return self;
}

- (bool) isEmpty
{
    return [gems count] == 0;
}

- (bool) isCellEmpty: (GridPosition) position
{
    return position.row >= 0 && [self get: position].type == EmptyGem;
}

- (bool) isCellValid: (GridPosition) position
{
    if (position.column < 0 || position.column >= self.width)
        return false;
    
    return true;
}

- (NSArray*) gems
{
    return [gems allObjects];
}

- (Gem*) put: (GemType) type at: (GridPosition) position
{
    if ([[self get: position] type] != EmptyGem)
    {
        @throw [NSException exceptionWithName:@"Grid" reason: @"Grid position is not empty" userInfo: nil];
    }
    
    Gem* gem = [[Gem alloc] initWithType: type at: position resources: resources];
    [gems addObject: gem];
    
    return gem;
}

- (Gem*) get: (GridPosition) position
{
    for (Gem* gem in gems)
    {
        if (gem.position.column == position.column &&
            gem.position.row == position.row)
        {
            return gem;
        }
    }
    
    return [[Gem alloc] initWithType: EmptyGem at: MakePosition(0, 0) resources: resources];
}

- (void) updateWithGravity: (float) gravity
{
    for (Gem* gem in gems)
    {
        [gem updateWithGravity: gravity onGrid: self];
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

    for (Gem* gem in grid.gems)
    {
        [gem drawIn: batch info: info];
    }
}


@end