//
//  Grid.m
//  Diamonds

#import "Grid.h"

GridPosition MakePosition(int column, int row)
{
    GridPosition position = { column, row };
    return position;
}

@implementation Gem
{
    GemType type; 
    GridPosition position;
}

@synthesize position;

- (id) initWithType: (GemType) gemType at: (GridPosition) newPosition
{
    self = [super init];
    if (self == nil)
        return nil;
    
    type = gemType;
    position = newPosition;
    
    return self;
}

- (GemType) type
{
    return type;
}

@end

@implementation Grid
{
    Gem* gem;
}

- (id) init
{
    self = [super init];
    if (self == nil)
        return nil;
    
    return self;
}

- (bool) isEmpty
{
    return gem == nil;
}

- (void) put: (GemType) type at: (GridPosition) position
{
    gem = [[Gem alloc] initWithType: Diamond at: position] ;
}

- (Gem*) get: (GridPosition) position
{
    return gem;
}


@end
