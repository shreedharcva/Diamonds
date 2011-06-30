//
//  TestSprite.m
//  Diamonds


#import "TestSprite.h"

#import "MockSpriteBatch.h"
#import "Sprite.h"
#import "Engine.h"

@interface TestSpriteBatch : TestCase

@end

@implementation TestSpriteBatch
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

- (void) testSpriteBatchIsEmptyWhenCreated
{
    assertTrue([batch isEmpty]);    
}

- (void) testSpriteBatchHoldsAReferenceToTheEngine
{    
    assertEqualObjects(engine, batch.engine); 
}

- (void) testSpriteBatchEndCalledRightAfterBeginDoesntDrawAnySprite
{
    [batch begin];
    [batch end];
    
    assertEquals(0, batch.spritesDrawn);
}

- (void) testSpriteBatchDrawsOneSpriteWhenOneSpriteIsAddedAfterBegin
{
    [batch begin];
    [[Sprite new] drawIn: batch];
    [batch end];
    
    assertEquals(1, batch.spritesDrawn);
}

- (void) testSpriteBatchDrawsTwoSpritesWhenTwoSpritesAreAddedAfterBegin
{
    [batch begin];
    [[Sprite new] drawIn: batch];
    [[Sprite new] drawIn: batch];
    [batch end];
    
    assertEquals(2, batch.spritesDrawn);
}

- (void) testSpriteIsDrawnInTheCorrectPosition
{
    Sprite* sprite = [Sprite new];
    CGPoint position = CGPointMake(100, 120);
    
    [sprite moveTo: position];
                         
    [batch begin];
    [sprite drawIn: batch];
    [batch end];
    
    assertEquals(position.x, [batch posiionOfTheLastSprite].x);
    assertEquals(position.y, [batch posiionOfTheLastSprite].y);
}

- (void) testSpriteIsDrawnWithTheCorrectSize
{
    Sprite* sprite = [Sprite new];
    CGSize size = CGSizeMake(100, 200);
    
    [sprite resizeTo: size];
    
    [batch begin];
    [sprite drawIn: batch];
    [batch end];
    
    assertEquals(size.width, [batch sizeOfTheLastSprite].width);
    assertEquals(size.height, [batch sizeOfTheLastSprite].height);
}

@end
