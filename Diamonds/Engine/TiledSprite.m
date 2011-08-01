//
//  TiledSprite.m
//  Diamonds

#import "TiledSprite.h"
#import "Texture.h"
#import "Sprite.h"
#import "SpriteBatch.h"

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
    int widthInTiles;
    int heightInTiles;
    
    NSMutableArray* tiles;
}

@synthesize tileSize;

@synthesize widthInTiles;
@synthesize heightInTiles;

- (id) initWithTexture: (Texture*) texture_
{
    self = [super initWithTexture: texture_];
    if (self == nil)
    {
        return nil;
    }
    
    tileSize = self.texture.size;
    
    widthInTiles = 1;
    heightInTiles = 1;
    
    tiles = [NSMutableArray array];

    [self setTile: MakeTile(0, 0) with: MakeTile(0, 0)];

    return self;
}

- (int) gridWidth
{
    return floor(self.texture.size.width / tileSize.width);
}

- (int) gridHeight
{
    return floor(self.texture.size.height / tileSize.height);
}

- (void) throwError: (TileCoordinates) source
{
    NSString* reason = [NSString stringWithFormat: @"%@\nSource tile out of bounds: [%d %d]", self, source.x, source.y];  
    
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject: self forKey: @"self"];
        
    @throw [NSException exceptionWithName: @"TiledSprite" reason: reason userInfo: userInfo];    
}

- (void) setTile: (TileCoordinates) coordinates with: (TileCoordinates) source
{    
    if (source.x >= [self gridWidth] || source.y >= [self gridHeight])
    {
        [self throwError: source];
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

- (void) removeTile: (TileCoordinates) coordinates
{
    Tile* tile = [self getTile: coordinates];
    if (tile != nil)
    {
        [tiles removeObject: tile];
    }    
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

- (void) drawIn: (SpriteBatch*) batch
{
    CGSize gridSize;
    gridSize.width = self.tileSize.width * self.widthInTiles;
    gridSize.height = self.tileSize.height * self.heightInTiles;
    
    CGSize sizeRatio;
    sizeRatio.width = self.size.width / gridSize.width;;
    sizeRatio.height = self.size.height / gridSize.height;
    
    for (Tile* tile in tiles)
    {
        CGPoint position = self.position;
        position.x += sizeRatio.width * tile.coordinates.x * self.tileSize.width;
        position.y += sizeRatio.height * tile.coordinates.y * self.tileSize.height;
        
        CGSize size = self.tileSize;
        size.width *= sizeRatio.width;
        size.height *= sizeRatio.height;

        CGRect sourceRectangle;        
        sourceRectangle.origin.x = tile.source.x * self.tileSize.width;
        sourceRectangle.origin.y = tile.source.y * self.tileSize.height;
        sourceRectangle.size = self.tileSize;
        
        [batch drawQuad: position size: size texture: self.texture sourceRect: sourceRectangle];        
    }
}

- (NSString*) description
{
    return [NSString stringWithFormat: @"%@ [tileSize: %2.0f %2.0f grid: %d %d]",
            [super description], 
            tileSize.width, tileSize.height,
            [self gridWidth], [self gridHeight]];
            
}

@end
