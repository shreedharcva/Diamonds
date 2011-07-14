//
//  Gem.m
//  Diamonds

#import "Gem.h"

#import "Sprite.h"
#import "SpriteBatch.h"
#import "ResourceManager.h"
#import "Grid.h"

@implementation Gem
{
    GemType type; 
    GemState state;
    
    GridPosition position;
    
    Sprite* sprite;
}

@synthesize type;
@synthesize state;
@synthesize position;
@synthesize cellHeight;

- (NSString*) getTextureNameFromType: (GemType) gemType
{
    if (gemType == Diamond)
        return @"diamond";
    if (gemType == Ruby)
        return @"ruby";
    
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

- (id) initWithType: (GemType) gemType at: (GridPosition) gridPosition resources: (ResourceManager*) resources
{
    self = [super init];
    if (self == nil)
        return nil;
    
    type = gemType;
    state = Stopped;
    
    position = gridPosition;
    cellHeight = 0.0f;
    
    [self initSpriteForType: gemType resources: resources];

    
    return self;
}

- (bool) canMoveRight: (Grid*) grid
{
    GridPosition newPosition = self.position;
    newPosition.column += 1;
    
    return [grid isCellEmpty: newPosition];    
}

- (bool) canMoveLeft: (Grid*) grid
{
    GridPosition newPosition = self.position;
    newPosition.column -= 1;
    
    return [grid isCellEmpty: newPosition];    
}

- (bool) canMoveDown: (Grid*) grid
{
    GridPosition newPosition = self.position;
    newPosition.row -= 1;
    
    return [grid isCellEmpty: newPosition];    
}

- (void) moveRightOn: (Grid*) grid
{
    if ([self canMoveRight: grid])
    {
        position.column += 1;
    }
}

- (void) moveLeftOn: (Grid*) grid
{
    if ([self canMoveLeft: grid])
    {
        position.column -= 1;
    }
}

- (void) updateWithGravity: (float) gravity onGrid: (Grid*) grid
{
    if (state == Falling)
    {
        cellHeight -= gravity;
        
        if (cellHeight < 0.00f)
        {
            cellHeight += 1.00f;

            if ([self canMoveDown: grid])
            {
                position.row -= 1;
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
            position.row -= 1;
            cellHeight = 1.00f - gravity;
            if (cellHeight > 0.0)
            {
                state = Falling;
            }
        }
    }
}

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;
{ 
    CGPoint spritePosition = info.origin;
    
    spritePosition.x += info.cellSize.width * self.position.column; 
    spritePosition.y -= info.cellSize.height * self.position.row - (info.cellSize.height * (info.heightInCells - 1)); 
    spritePosition.y += (-cellHeight) * info.cellSize.height;
    
    [sprite moveTo: spritePosition];
    [sprite drawIn: batch];
}

- (NSString*) description
{
    if (type == Diamond)
        return @"Diamond";
    if (type == Diamond)
        return @"Ruby";
    
    return @"EmptyGem";
}

@end
