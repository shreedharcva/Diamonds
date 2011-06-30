//
//  TestSprite.m
//  Diamonds


#import "TestSprite.h"
#import "Sprite.h"
#import "Engine.h"

@interface MockEngine: Engine
@end

@implementation MockEngine
@end

@interface SpriteBatch (Testing)

@property (readonly) int spritesDrawn;

@end

@implementation SpriteBatch (Testing)

- (int) spritesDrawn
{
    return 0;
}

@end

@interface MockSpriteBatch : SpriteBatch 

- (int) spritesDrawn;

- (Position) lastDrawnSpritePosition;

@end

@implementation MockSpriteBatch
{
    int spritesDrawn;
    Position lastDrawnSpritePosition;
}

- (int) spritesDrawn
{
    return spritesDrawn;
}

- (Position) lastDrawnSpritePosition
{
    return lastDrawnSpritePosition;
}

- (void) drawQuad: (Position) position
{
    ++spritesDrawn;
    lastDrawnSpritePosition = position;
}

@end

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
    Position position = { 100, 120 };
    
    [sprite moveTo: position];
                         
    [batch begin];
    [sprite drawIn: batch];
    [batch end];
    
    assertEquals(position.x, [batch lastDrawnSpritePosition].x);
    assertEquals(position.y, [batch lastDrawnSpritePosition].y);
}

@end
