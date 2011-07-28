//
//  TestTiledSprite.m
//  Diamonds

#import "TestTiledSprite.h"

#import "TiledSprite.h"
#import "MockTexture.h"
#import "MockEngine.h"
#import "MockSpriteBatch.h"

@interface TestTiledSpriteBase : TestCase 
{
@protected
    MockTexture* texture;
    TiledSprite* sprite; 
}

@end

@implementation TestTiledSpriteBase

- (void) setUp
{
    texture = [MockTexture new];
    [texture setSize: CGSizeMake(128, 128)];
    
    sprite = [[TiledSprite alloc] initWithTexture: texture];    
}

@end

@interface TestTiledSprite : TestTiledSpriteBase 

@end

@implementation TestTiledSprite

- (void) testTiledSpriteTileSizeIsAsBigAsTheInputTextureWhenCreated
{
    assertEquals(texture.size, sprite.tileSize);
}

- (void) testTiledSpriteWidthAndHeightInTilesIs1x1WhenCreated
{
    assertEquals(1, sprite.widthInTiles);
    assertEquals(1, sprite.heightInTiles);    
}

- (void) testTiledSpriteWidthAndHeightInTilesAreCorrectWhenSet
{
    [sprite setWidthInTiles: 4];
    [sprite setHeightInTiles: 4];

    assertEquals(4, sprite.widthInTiles);
    assertEquals(4, sprite.heightInTiles);    
}

- (void) testTiledSpriteGridIs1x1WhenCreated
{
    assertEquals(1, sprite.gridWidth);
    assertEquals(1, sprite.gridHeight);
}

- (void) testTiledSpriteHasTheCorrectGridSize
{
    [sprite setGridWidth: 4];
    [sprite setGridHeight: 4];

    assertEquals(4, sprite.gridWidth);
    assertEquals(4, sprite.gridHeight);
}

- (void) testGetTileReturnsTheUpperLeftTileWhenTheSpriteIsCreated
{
    assertEquals(MakeTile(0, 0), [sprite getTile: MakeTile(0, 0)].coordinates);
}

- (void) testSetTileUpdatesTheTileCorrectly
{
    [sprite setGridWidth: 4];
    [sprite setGridHeight: 4];

    [sprite setWidthInTiles: 2];
    [sprite setHeightInTiles: 2];

    [sprite setTile: MakeTile(1, 1) with: MakeTile(2, 2)];
    
    assertEquals(MakeTile(2, 2), [sprite getTile: MakeTile(1, 1)].source);
}

@end

@interface TestTiledSpriteDrawing : TestTiledSpriteBase 

@end

@implementation TestTiledSpriteDrawing
{
    MockEngine* engine;
    MockSpriteBatch* batch;
}

- (void) setUp
{
    [super setUp];
    
    engine = [MockEngine new];
    batch = [[MockSpriteBatch alloc] initWithEngine: engine];
}


@end
