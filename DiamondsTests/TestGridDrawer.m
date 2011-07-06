//
//  TestGridDrawer.m
//  Diamonds

#import "TestGridDrawer.h"
#import "MockSpriteBatch.h"

#import "Grid.h"

@interface TestGridDrawer: TestCase 
@end

@implementation TestGridDrawer
{
    Grid* grid;
}

- (void) setUp
{
    [super setUp];
    grid = [Grid new];
}

- (void) testNoSpriteIsDrawnByGridDrawerWhenTheGridIsEmpty
{
    /*
    Engine* engine = [MockEngine new];
    Grid* grid = [Grid new];
    GridDrawer* gridDrawer = [[GridDrawer alloc] initWithGrid: grid];
    MockSpriteBatch* batch = [MockSpriteBatch new];
    
    [gridDrawer drawIn: batch];

    assertEquals(0, [batch numberOfSpritesDrawn]);*/
}

@end

