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
    
    sprite = [[TiledSprite alloc] initWithTexture: texture tileSize: CGSizeMake(32, 32)];    
}

@end

@interface TestTiledSprite : TestTiledSpriteBase 

@end

@implementation TestTiledSprite

- (void) testTiledSpriteTileSizeIsAsBigAsTheInputTextureWhenCreated
{
    assertEquals(CGSizeMake(32, 32), sprite.tileSize);
}

- (void) testTiledSpriteWidthAndHeightInTilesIs1x1WhenCreated
{
    assertEquals(1, sprite.widthInTiles);
    assertEquals(1, sprite.heightInTiles);    
}

- (void) testTiledSpriteHasTheCorrectGridSize
{
    assertEquals(4, sprite.gridWidth);
    assertEquals(4, sprite.gridHeight);
}

- (void) testGetTileReturnsTheUpperLeftTileWhenTheSpriteIsCreated
{
    assertEquals(MakeTile(0, 0), [sprite getTile: MakeTile(0, 0)].coordinates);
}

@end

@interface TestTiledSpriteWithTiles : TestTiledSpriteBase 
@end

@implementation TestTiledSpriteWithTiles

- (void) testSetTileUpdatesAnEmptyTileCorrectly
{
    [sprite setTile: MakeTile(1, 1) with: MakeTile(2, 2)];
    
    assertEquals(MakeTile(2, 2), [sprite getTile: MakeTile(1, 1)].source);
}

- (void) testSetTileUpdatesATileCorrectly
{   
    [sprite setTile: MakeTile(1, 1) with: MakeTile(2, 2)];
    [sprite setTile: MakeTile(1, 1) with: MakeTile(1, 1)];
    
    assertEquals(MakeTile(1, 1), [sprite getTile: MakeTile(1, 1)].source);
}

- (void) testSetTileUpdatesWidthAndHeightInTiles
{   
    [sprite setTile: MakeTile(2, 1) with: MakeTile(2, 2)];
    [sprite setTile: MakeTile(1, 1) with: MakeTile(1, 1)];
    
    assertEquals(3, sprite.widthInTiles);
    assertEquals(2, sprite.heightInTiles);    
}

- (void) testSetTileUpdatesSpriteSize
{   
    [sprite setTile: MakeTile(2, 1) with: MakeTile(1, 1)];
    [sprite updateSizeFromTiles];
    
    assertEquals(CGSizeMake(32 * sprite.widthInTiles, 32 * sprite.heightInTiles), sprite.size);
}

- (void) testTiledSpriteThrowsAnExceptionIfTheSourceTileIsOutOfBounds
{
    assertThrows(
    {
        [sprite setTile: MakeTile(1, 1) with: MakeTile(10, 10)];
    });
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
 
    [sprite removeTile: MakeTile(0, 0)];

    engine = [MockEngine new];
    batch = [[MockSpriteBatch alloc] initWithEngine: engine];
}

- (void) testTwoSpritesAreSubmittedWhenTheTiledSpriteHasTwoTiles
{
    [sprite setTile: MakeTile(0, 0) with: MakeTile(0, 0)];
    [sprite setTile: MakeTile(1, 1) with: MakeTile(0, 0)];
    
    [batch begin];
    [sprite drawIn: batch];
    [batch end];
    
    assertEquals(2, batch.numberOfSpritesDrawn);
}

- (void) testTiledSpriteDrawsTileAtTheCorrectPosition
{
    [sprite setTile: MakeTile(2, 1) with: MakeTile(0, 0)];
    [sprite updateSizeFromTiles];
    
    [batch begin];
    [sprite drawIn: batch];
    [batch end];
    
    assertEquals(CGPointMake(64, 32), batch.lastSprite.position);
}

- (void) testTiledSpriteDrawsTileAtTheCorrectPositionWhenTheSpriteIsResized
{
    [sprite setTile: MakeTile(1, 1) with: MakeTile(0, 0)];
    [sprite updateSizeFromTiles];
    [sprite resizeTo: CGSizeMake(128, 128)];
    
    [batch begin];
    [sprite drawIn: batch];
    [batch end];
    
    assertEquals(CGPointMake(64, 64), batch.lastSprite.position);
}

- (void) testTiledSpriteDrawsTileWitTheCorrectSizeWhenTheSpriteIsResized
{
    [sprite setTile: MakeTile(1, 1) with: MakeTile(0, 0)];
    [sprite updateSizeFromTiles];
    [sprite resizeTo: CGSizeMake(128, 128)];
    
    [batch begin];
    [sprite drawIn: batch];
    [batch end];
    
    assertEquals(CGSizeMake(64, 64), batch.lastSprite.size);
}

- (void) testTiledSpriteDrawsTileWithTheCorrectSize
{
    [sprite setTile: MakeTile(2, 1) with: MakeTile(0, 0)];
    [sprite updateSizeFromTiles];
    
    [batch begin];
    [sprite drawIn: batch];
    [batch end];
    
    assertEquals(CGSizeMake(32, 32), batch.lastSprite.size);
}

- (void) testTiledSpriteDrawsTileWithTheCorrectSourceRectangle
{
    [sprite setTile: MakeTile(2, 1) with: MakeTile(2, 1)];
    [sprite updateSizeFromTiles];
    
    [batch begin];
    [sprite drawIn: batch];
    [batch end];
    
    assertEquals(CGRectMake(64, 32, 32, 32), batch.lastSprite.sourceRect);
}


@end
