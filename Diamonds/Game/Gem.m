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
    
    sprite = [[Sprite alloc] initWithTexture: [self getTextureFromType: gemType resources: resources]];
 
    [sprite setSourceRectangle: CGRectMake(0, 0, 32, 32)];
    [sprite resizeTo: CGSizeMake(32, 32)];
    
    return self;
}

- (void) update: (Grid*) grid
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
        state = Falling;
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

@end
