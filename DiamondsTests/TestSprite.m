//
//  TestSprite.m
//  Diamonds

#import "TestSprite.h"

#import "Sprite.h"

CGVector CGVectorMake(float x, float y)
{
    return CGPointMake(x, y);
}

@interface TestSprite : TestCase 
@end

@implementation TestSprite
{
    Sprite* sprite;
}

- (void) setUp
{
    [super setUp];

    sprite = [Sprite new];
}

- (void) testSpriteMovesDownWhenSpeedIsSetWithADownwardVector
{
    [sprite moveTo: CGPointMake(100, 100)];
    [sprite moveBy: CGVectorMake(0, 10)];
    
    assertEquals(110.0f, sprite.position.y);
}

- (void) testSpriteMovesDownWhenSpeedIsSetWithAVectorPointingRight
{
    [sprite moveTo: CGPointMake(100, 100)];
    [sprite moveBy: CGVectorMake(15, 0)];
    
    assertEquals(115.0f, sprite.position.x);
}

@end
