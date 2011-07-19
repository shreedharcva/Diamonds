//
//  TestGridDrawer.m
//  Diamonds

#import "TestGridDrawer.h"

#import "Grid.h"
#import "Texture.h"

#import "MockSpriteBatch.h"
#import "MockResourceManager.h"
#import "MockTexture.h"

@interface TestGridDrawer: TestCase 
@end

@implementation TestGridDrawer
{
    ResourceManager* resources;

    GridPresentationInfo info;
    
    Grid* grid;
    GridDrawer* gridDrawer;
    MockSpriteBatch* batch;
}

- (void) setUp
{
    [super setUp];

    resources = [MockResourceManager new];
    
    info.origin = CGPointMake(100, 100);
    info.cellSize = CGSizeMake(32, 32);
    info.heightInCells = 14;
    
    grid = [[Grid alloc] initWithResources: resources width: 8 height: 14];
    gridDrawer = [[GridDrawer alloc] initWithGrid: grid info: info];
    batch = [MockSpriteBatch new];
}

- (void) drawGrid
{
    [batch begin];
    [gridDrawer drawIn: batch];
    [batch end];    
}

- (CGPoint) screenPositionFrom: (GridCell) cell
{
    CGPoint expectedCell;
    expectedCell.x = info.origin.x + info.cellSize.width * cell.column; 
    expectedCell.y = info.origin.y + (info.cellSize.height * (info.heightInCells - 1)) - info.cellSize.height * cell.row;
    
    return expectedCell;
}

- (void) testNoSpriteIsDrawnByGridDrawerWhenTheGridIsEmpty
{
    [self drawGrid];

    assertEquals(0, [batch numberOfSpritesDrawn]);
}

- (void) testBackgroundSpriteHasTheCorrectSourceTexture
{
    MockTexture* texture = [MockTexture new];
    Sprite* background = [[Sprite alloc] initWithTexture: texture];
    
    [gridDrawer setBackground: background];
    
    [batch begin];
    [gridDrawer drawBackgroundIn: batch];
    [batch end];    
    
    assertEqualObjects(texture, [batch lastSprite].texture);
}

- (void) testOneSpriteIsDrawnByGridDrawerWhenTheGridContainsOneGem
{
    [grid put: Diamond at: MakeCell(0, 0)];
    [self drawGrid];
    
    assertEquals(1, [batch numberOfSpritesDrawn]);
}

- (void) testTwoSpritesAreDrawnByGridDrawerWhenTheGridContainsTwoGems
{
    [grid put: Diamond at: MakeCell(0, 0)];
    [grid put: Ruby at: MakeCell(1, 0)];

    [self drawGrid];
    
    assertEquals(2, [batch numberOfSpritesDrawn]);
}

- (void) testTheLastSpriteDrawnIsUsingARubyTexture
{
    [grid put: Ruby at: MakeCell(1, 0)];
    
    [self drawGrid];
    
    assertEqualObjects(@"ruby", [batch lastSprite].texture.name);
}

- (void) testTheSpriteIsDrawnInTheCorrectPosition
{
    GridCell cell = MakeCell(1, 2);
    [grid put: Ruby at: cell];
    
    [self drawGrid];

    assertEquals([self screenPositionFrom: cell], [batch lastSprite].position);
}

@end

