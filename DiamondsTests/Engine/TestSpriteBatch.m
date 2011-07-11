//
//  TestSprite.m
//  Diamonds


#import "TestSpriteBatch.h"

#import "Sprite.h"
#import "Engine.h"

#import "MockEngine.h"
#import "MockSpriteBatch.h"
#import "MockTexture.h"

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
    
    assertEquals(0, batch.numberOfSpritesDrawn);
}

- (void) testSpriteBatchDrawsOneSpriteWhenOneSpriteIsAddedAfterBegin
{
    [batch begin];
    [[Sprite new] drawIn: batch];
    [batch end];
    
    assertEquals(1, batch.numberOfSpritesDrawn);
}

- (void) testSpriteBatchDrawsTwoSpritesWhenTwoSpritesAreAddedAfterBegin
{
    [batch begin];
    [[Sprite new] drawIn: batch];
    [[Sprite new] drawIn: batch];
    [batch end];
    
    assertEquals(2, batch.numberOfSpritesDrawn);
}

- (void) testSpriteBatchThrowsAnExceptionWhenASpriteIsAddedBeforeBeginIsCalled
{
    assertThrows(
    {
        [[Sprite new] drawIn: batch];
    });

    [batch begin];
    [batch end];    
}

- (void) testSpriteBatchThrowsAnExceptionWhenASpriteIsAddedAfterEndIsCalled
{
    [batch begin];
    [batch end];    
    
    assertThrows(
    {
        [[Sprite new] drawIn: batch];
    });
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

- (void) testSpriteIsDrawnWithTheCorrectSourceRectangle
{
    MockTexture* texture = [MockTexture new];
    
    CGSize size = CGSizeMake(64, 128);
    [texture setSize: size];
    
    Sprite* sprite = [[Sprite alloc] initWithTexture: texture];
    CGRect sourceRectangle = CGRectMake(0, 0, 32, 32);
    
    [sprite setSourceRectangle: sourceRectangle];
    
    [batch begin];
    [sprite drawIn: batch];
    [batch end];
    
    assertEquals(0.00f, [batch sourceRectangleOfTheLastSprite].origin.x);
    assertEquals(0.00f, [batch sourceRectangleOfTheLastSprite].origin.y);
    assertEquals(0.50f, [batch sourceRectangleOfTheLastSprite].size.width);
    assertEquals(0.25f, [batch sourceRectangleOfTheLastSprite].size.height);
}

@end
