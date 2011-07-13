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
    float cellHeight;
    
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

- (id) initWithType: (GemType) gemType at: (GridPosition) gridPosition resources: (ResourceManager*) resources
{
    self = [super init];
    if (self == nil)
        return nil;
    
    type = gemType;
    state = Stopped;
    position = gridPosition;
    cellHeight = 0.0f;
    
    sprite = [[Sprite alloc] initWithTexture: [self getTextureFromType: gemType resources: resources]];
 
    [sprite setSourceRectangle: CGRectMake(0, 0, 32, 32)];
    [sprite resizeTo: CGSizeMake(32, 32)];
    
    return self;
}

- (void) update: (Grid*) grid
{
    if (state == Falling)
    {
        cellHeight -= 0.10f;
        if (cellHeight <= 0)
        {
            position.row -= 1;
        }
        return;
    }    
    else
    if (state == Stopped)
    {
        GridPosition lowerPosition = self.position;
        lowerPosition.row -= 1;
        
        if (lowerPosition.row < 0)
        {
            state = Stopped;
        }
        else    
        if ([grid get: lowerPosition].type == EmptyGem)
        {
            position.row -= 1;
            cellHeight = 1.00f;
            state = Falling;
        }
    }
}

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;
{ 
    CGPoint spritePosition = info.origin;
    
    spritePosition.x += info.cellSize.width * self.position.column; 
    spritePosition.y -= info.cellSize.height * self.position.row - (info.cellSize.height * (info.heightInCells - 1)); 
    
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
