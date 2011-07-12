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

    Grid* grid;
    GridDrawer* gridDrawer;
    MockSpriteBatch* batch;
}

- (void) setUp
{
    [super setUp];

    resources = [MockResourceManager new];
    
    grid = [[Grid alloc] initWithResources: resources];
    gridDrawer = [[GridDrawer alloc] initWithGrid: grid];
    batch = [MockSpriteBatch new];
}

- (void) drawGrid
{
    [batch begin];
    [gridDrawer drawIn: batch];
    [batch end];    
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

@end

