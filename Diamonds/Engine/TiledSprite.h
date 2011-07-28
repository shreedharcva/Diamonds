//
//  TiledSprite.h
//  Diamonds

#import "Sprite.h"

typedef struct TileCoordinates
{
    int x;
    int y;
    
} TileCoordinates;

TileCoordinates MakeTile(int x, int y);

@interface Tile : NSObject 
{
    TileCoordinates coordinates;
    TileCoordinates source;
}

- (id) initWithCoordinates: (TileCoordinates) coordinates_;

@property (readonly, nonatomic) TileCoordinates coordinates;
@property (assign, nonatomic) TileCoordinates source;

@end

@interface TiledSprite : Sprite

- (id) initWithTexture: (Texture*) texture_ tileSize: (CGSize) tileSize_;

- (void) setTile: (TileCoordinates) tile with: (TileCoordinates) source;
- (Tile*) getTile: (TileCoordinates) tile;

- (void) updateSizeFromTiles;

@property (readonly, nonatomic) CGSize tileSize;

@property (readonly, nonatomic) int widthInTiles;
@property (readonly, nonatomic) int heightInTiles;

@property (assign, nonatomic) int gridWidth;
@property (assign, nonatomic) int gridHeight;

@end
