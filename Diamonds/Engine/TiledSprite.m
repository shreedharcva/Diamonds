//
//  TiledSprite.m
//  Diamonds

#import "TiledSprite.h"
#import "Texture.h"
#import "Sprite.h"

TileCoordinates MakeTile(int x, int y)
{
    TileCoordinates tile;
    tile.x = x;
    tile.y = y;
    return tile;
}

@implementation Tile

@synthesize coordinates;
@synthesize source;

- (id) initWithCoordinates: (TileCoordinates) coordinates_
{
    self = [super init];
    if (self == nil)
    {
        return nil;
    }
    
    coordinates = coordinates_;
    
    return self;
}

@end


@implementation TiledSprite
{
    int gridWidth;
    int gridHeight;
    
    int widthInTiles;
    int heightInTiles;
    
    NSMutableArray* tiles;
}

@synthesize widthInTiles;
@synthesize heightInTiles;

@synthesize gridWidth;
@synthesize gridHeight;

- (id) initWithTexture: (Texture*) texture_
{
    self = [super initWithTexture: texture_];
    if (self == nil)
    {
        return nil;
    }
    
    gridWidth = 1;
    gridHeight = 1;
    
    widthInTiles = 1;
    heightInTiles = 1;
    
    tiles = [NSMutableArray array];

    [self setTile: MakeTile(0, 0) with: MakeTile(0, 0)];

    return self;
}

- (void) setTile: (TileCoordinates) coordinates with: (TileCoordinates) source
{
    Tile* tile = [[Tile alloc] initWithCoordinates: coordinates];
    tile.source = source;
    [tiles addObject: tile];
}

- (Tile*) getTile: (TileCoordinates) coordinates
{
    for (Tile* tile in tiles)
    {
        if (
            tile.coordinates.x == coordinates.x &&
            tile.coordinates.y == coordinates.y)
        {
            return tile;
        }
    }
    
    return nil;
}

- (CGSize) tileSize
{
    return self.texture.size;
}


@end
