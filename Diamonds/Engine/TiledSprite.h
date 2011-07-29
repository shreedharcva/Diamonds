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

- (id) initWithTexture: (Texture*) texture_;

- (void) setTile: (TileCoordinates) coordinates with: (TileCoordinates) source;
- (void) removeTile: (TileCoordinates) coordinates;

- (Tile*) getTile: (TileCoordinates) coordinates;

- (void) updateSizeFromTiles;

@property (assign, nonatomic) CGSize tileSize;

@property (readonly, nonatomic) int widthInTiles;
@property (readonly, nonatomic) int heightInTiles;

@property (readonly, nonatomic) int gridWidth;
@property (readonly, nonatomic) int gridHeight;

@end
