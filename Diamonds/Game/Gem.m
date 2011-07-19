//
//  Gem.m
//  Diamonds

#import "Gem.h"

#import "Sprite.h"
#import "SpriteBatch.h"
#import "ResourceManager.h"
#import "Grid.h"

@interface Gem (private)
@property (readonly) Sprite* sprite;
@end

@implementation Gem
{
    GemType type; 
        
    Sprite* sprite;
}

@synthesize type;

- (NSString*) getTextureNameFromType: (GemType) gemType
{
    if (gemType == Diamond)
        return @"diamond";
    if (gemType == Ruby)
        return @"ruby";
    if (gemType == Sapphire)
        return @"sapphire";
    
    return nil;
}

- (Texture*) getTextureFromType: (GemType) gemType resources: (ResourceManager*) resources
{
    if (gemType == EmptyGem)
        return nil;
    
    return [resources loadTexture: [self getTextureNameFromType: gemType]];
}

- (void) initSpriteForType: (GemType) gemType resources: (ResourceManager*) resources   
{
    sprite = [[Sprite alloc] initWithTexture: [self getTextureFromType: gemType resources: resources]];

    [sprite setSourceRectangle: CGRectMake(0, 0, 32, 32)];
    [sprite resizeTo: CGSizeMake(32, 32)];
}

- (id) initWithType: (GemType) gemType at: (GridCell) cell_ resources: (ResourceManager*) resources
{
    self = [super initAt: cell_ width: 1 height: 1];
    if (self == nil)
        return nil;
    
    type = gemType;
    
    [self initSpriteForType: gemType resources: resources];
    
    return self;
}

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;
{ 
    CGPoint spritePosition = info.origin;
    
    spritePosition.x += info.cellSize.width * self.cell.column; 
    spritePosition.y -= info.cellSize.height * self.cell.row - (info.cellSize.height * (info.heightInCells - 1)); 
    spritePosition.y += (-self.cellHeight) * info.cellSize.height;
    
    [sprite moveTo: spritePosition];
    [sprite drawIn: batch];
}

- (NSString*) description
{
    NSString* typeString = @"NoType";
    
    if (type == Diamond)
        typeString =  @"Diamond";
    if (type == Ruby)
        typeString =  @"Ruby";
    if (type == Sapphire)
        typeString =  @"Sapphire";
    
    return [NSString stringWithFormat: @"[%p] %@ (%d %d)", self, typeString, self.cell.column, self.cell.row]; 
}

- (Sprite*) sprite
{
    return sprite;
}

@end

@implementation GemAggregate
{
    NSMutableArray* droppables;
}

- (id) initAt: (GridCell) cell_ width: (int) width_ height: (int) height_
{
    self = [super initAt: cell_ width: width_ height: height_];
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

- (void) releaseOn: (Grid*) grid
{
    [grid remove: self];
    
    for (Droppable* droppable in droppables)
    {
        [droppable detachFromParent];
        [grid put: droppable];
    }
}

@end

@implementation DroppablePair
{
    Gem* buddy;
    Gem* pivot;
}

@synthesize pivot;
@synthesize buddy;

- (Gem*) addGem: (GemType) gemType at: (GridCell) cell_ resources: (ResourceManager*) resources;
{
    Gem* gem = [[Gem alloc] initWithType: gemType at: cell_ resources: resources];
    [self add: gem];
    return gem;    
}

- (id) initAt: (GridCell) cell_ with: (GemType[]) gems resources: (ResourceManager*) resources
{
    self = [super initAt: cell_ width: 1 height: 2];
    if (self == nil)
    {
        return nil;
    }

    pivot = [self addGem: gems[0] at: MakeCell(0, 0) resources: resources];
    buddy = [self addGem: gems[1] at: MakeCell(0, 1) resources: resources];

    return self;
}

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info
{
    [pivot drawIn: batch info: info];
    [buddy drawIn: batch info: info];
}

- (NSString*) description
{
    return [NSString stringWithFormat: @"[%p] DroppablePair <%@, %@>", self, pivot, buddy];
}

@end