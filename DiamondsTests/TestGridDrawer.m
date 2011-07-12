//
//  TestGridDrawer.m
//  Diamonds

#import "TestGridDrawer.h"

#import "Grid.h"
#import "Texture.h"

#import "MockSpriteBatch.h"
#import "MockResourceManager.h"

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
    
    info.origin = CGPointMake(0, 0);
    info.cellSize = CGSizeMake(32, 32);
    
    grid = [[Grid alloc] initWithResources: resources];
    gridDrawer = [[GridDrawer alloc] initWithGrid: grid info: info];
    batch = [MockSpriteBatch new];
}

- (void) drawGrid
{
    [batch begin];
    [gridDrawer drawIn: batch];
    [batch end];    
}

- (CGPoint) screenPositionFrom: (GridPosition) gridPosition
{
    CGPoint expectedPosition;
    expectedPosition.x = info.origin.x + info.cellSize.width * gridPosition.column; 
    expectedPosition.y = info.origin.y - info.cellSize.height * gridPosition.row;
    
    return expectedPosition;
}

- (void) testNoSpriteIsDrawnByGridDrawerWhenTheGridIsEmpty
{
    [self drawGrid];

    assertEquals(0, [batch numberOfSpritesDrawn]);
}

- (void) testOneSpriteIsDrawnByGridDrawerWhenTheGridContainsOneGem
{
    [grid put: Diamond at: MakePosition(0, 0)];
    [self drawGrid];
    
    assertEquals(1, [batch numberOfSpritesDrawn]);
}

- (void) testTwoSpritesAreDrawnByGridDrawerWhenTheGridContainsTwoGems
{
    [grid put: Diamond at: MakePosition(0, 0)];
    [grid put: Ruby at: MakePosition(1, 0)];

    [self drawGrid];
    
    assertEquals(2, [batch numberOfSpritesDrawn]);
}

- (void) testTheLastSpriteDrawnIsUsingARubyTexture
{
    [grid put: Ruby at: MakePosition(1, 0)];
    
    [self drawGrid];
    
    assertEqualObjects(@"ruby", [batch lastSprite].texture.name);
}

- (void) testTheSpriteIsDrawnInTheCorrectPosition
{
    GridPosition gridPosition = MakePosition(1, 2);
    [grid put: Ruby at: gridPosition];
    
    [self drawGrid];

    assertEquals([self screenPositionFrom: gridPosition], [batch lastSprite].position);
}

@end

