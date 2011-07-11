//
//  Grid.m
//  Diamonds

#import "Grid.h"

#import "Sprite.h"
#import "SpriteBatch.h"
#import "ResourceManager.h"

GridPosition MakePosition(int column, int row)
{
    GridPosition position = { column, row };
    return position;
}

@implementation Gem
{
    GemType type; 
    GridPosition position;
    
    Sprite* sprite;
}

@synthesize position;

- (id) initWithType: (GemType) gemType at: (GridPosition) newPosition resources: (ResourceManager*) resources
{
    self = [super init];
    if (self == nil)
        return nil;
    
    type = gemType;
    position = newPosition;
    
    sprite = [[Sprite alloc] initWithTexture: nil];
    
    return self;
}

- (void) drawIn: (SpriteBatch*) batch
{ 
    [sprite drawIn: batch];
}

- (GemType) type
{
    return type;
}

@end

@implementation Grid
{
    NSMutableSet* gems;
}

- (id) init
{
    self = [super init];
    if (self == nil)
        return nil;
    
    gems = [NSMutableSet new];
    
    return self;
}

- (bool) isEmpty
{
    return [gems count] == 0;
}

- (void) put: (GemType) type at: (GridPosition) position
{
    if ([[self get: position] type] != EmptyGem)
    {
        @throw [NSException exceptionWithName:@"Grid" reason: @"Grid position is not empty" userInfo: nil];
    }
    
    [gems addObject: [[Gem alloc] initWithType: type at: position resources: nil]];
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
    
    return [[Gem alloc] initWithType: EmptyGem at: MakePosition(0, 0) resources: nil];
}


@end
