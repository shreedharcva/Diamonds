//
//  Grid.m
//  Diamonds

#import "Grid.h"
#import "Gem.h"

GridPosition MakePosition(int column, int row)
{
    GridPosition position = { column, row };
    return position;
}

@implementation Grid
{
    ResourceManager* resources;
    NSMutableSet* gems;
}

- (id) initWithResources: (ResourceManager*) resourceManager
{
    self = [super init];
    if (self == nil)
        return nil;
    
    resources = resourceManager;
    
    gems = [NSMutableSet new];
    
    return self;
}

- (bool) isEmpty
{
    return [gems count] == 0;
}

- (NSArray*) gems
{
    return [gems allObjects];
}

- (void) put: (GemType) type at: (GridPosition) position
{
    if ([[self get: position] type] != EmptyGem)
    {
        @throw [NSException exceptionWithName:@"Grid" reason: @"Grid position is not empty" userInfo: nil];
    }
    
    Gem* gem = [[Gem alloc] initWithType: type at: position resources: resources];
    [gems addObject: gem];
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

@end

@implementation GridDrawer
{
    Grid* grid;
    GridPresentationInfo info;
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