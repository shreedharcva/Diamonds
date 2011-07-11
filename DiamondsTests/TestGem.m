//
//  TestGem.m
//  Diamonds

#import "TestGem.h"
#import "Grid.h"
#import "MockSpriteBatch.h"


@interface TestGem: TestCase 
@end

@implementation TestGem
{
}

- (void) setUp
{
    [super setUp];
}

- (void) testGemDrawsASprite
{
    Gem* gem = [[Gem alloc] initWithType: Diamond at: MakePosition(0, 0) resources: nil];

    MockSpriteBatch* batch = [MockSpriteBatch new];
    
    [batch begin];
    [gem drawIn: batch];
    [batch end];

    assertEquals(1, [batch numberOfSpritesDrawn]);
}

@end

