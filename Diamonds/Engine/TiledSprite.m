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
    CGSize tileSize;
    
    int gridWidth;
    int gridHeight;
    
    int widthInTiles;
    int heightInTiles;
    
    NSMutableArray* tiles;
}

@synthesize tileSize;

@synthesize widthInTiles;
@synthesize heightInTiles;

@synthesize gridWidth;
@synthesize gridHeight;

- (id) initWithTexture: (Texture*) texture_ tileSize: (CGSize) tileSize_
{
    self = [super initWithTexture: texture_];
    if (self == nil)
    {
        return nil;
    }
    
    tileSize = tileSize_;
    
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
    if (source.x >= gridWidth || source.y >= gridHeight)
    {
        @throw [NSException exceptionWithName:@"TiledSprite" reason: @"Source tile out of bounds" userInfo: nil];        
    }
    if (coordinates.x + 1 > widthInTiles)
    {
        widthInTiles = coordinates.x + 1;
    }

    if (coordinates.y + 1 > heightInTiles)
    {
        heightInTiles = coordinates.y + 1;
    }

    Tile* tile = [self getTile: coordinates];
    if (tile == nil)
    {
        tile = [[Tile alloc] initWithCoordinates: coordinates];   
        [tiles addObject: tile];
    }
    
    tile.source = source;
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

- (void) updateSizeFromTiles
{
    [self resizeTo: CGSizeMake(
        self.tileSize.width * self.widthInTiles,
        self.tileSize.height * self.heightInTiles)];
}

@end
