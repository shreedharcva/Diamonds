//
//  TestGame.m
//  Diamonds

#import "TestGame.h"

#import "Game.h"
#import "Engine.h"
#import "MockEngine.h"

@interface MockTimer : GameTimer

- (void) setCurrentTime: (float) milliseconds;

@end

@implementation MockTimer
{
    float milliseconds;
}

- (float) milliseconds
{
    return milliseconds;
}

- (void) setCurrentTime: (float) newMilliseconds
{
    milliseconds = newMilliseconds;
}

@end

@interface MockGame : Game 

@property (strong) GameTimer* timer;

@property (readonly) bool drawWasCalled;
@property (readonly) float lastDrawTimeInMilliseconds;
@property (readonly) float lastElapsedTimeInMilliseconds;

@end

@implementation MockGame
{
    bool drawWasCalled;
    
    float lastDrawTimeInMilliseconds;
    float lastElapsedTimeInMilliseconds;
}

@synthesize timer;
@synthesize drawWasCalled;
@synthesize lastDrawTimeInMilliseconds;
@synthesize lastElapsedTimeInMilliseconds;

- (void) draw: (GameTime*) gameTime
{
    lastDrawTimeInMilliseconds = gameTime.milliseconds;
    lastElapsedTimeInMilliseconds = gameTime.elapsedTimeInMilliseconds;
    
    drawWasCalled = true;
}

@end


@interface TestGame : TestCase 
@end

@implementation TestGame
{
    MockEngine* engine;
    MockGame* game;
}

- (void) setUp
{
    [super setUp];
    
    engine = [MockEngine new]; 
    game = [[MockGame alloc] initWithEngine: engine];
}

- (void) testGameIsCreatedWithAnEngine
{
    assertEqualObjects(engine, game.engine);
}

- (void) testGameCallsBeginAndEndOnTheEngineWhenDrawFrameIsCalled
{
    [game drawFrame];

    assertTrue(engine.beginWasCalled);
    assertTrue(engine.endWasCalled);
}

- (void) testGameCallsDrawOnTheSubClassWhenDrawFrameIsCalled
{
    [game drawFrame];
    
    assertTrue(game.drawWasCalled);
}

@end

@interface TestGameTime : TestCase

@end

@implementation TestGameTime
{
    MockEngine* engine;
    MockGame* game;
    MockTimer* timer;
}

- (void) setUp
{
    [super setUp];

    engine = [MockEngine new]; 
    game = [[MockGame alloc] initWithEngine: engine];

    timer = [MockTimer new];
    game.timer = timer;
}

- (void) testGameCallsDrawWithTheCorrectTimeObject
{
    
    [timer setCurrentTime: 0];
    [game drawFrame];
    
    assertEquals((float) 0.0f, game.lastDrawTimeInMilliseconds);
}

- (void) testGameCallsDrawWithTheCorrectTimeObjectAfterSomeTimerAdvances
{
    [timer setCurrentTime: 0];
    [game drawFrame];
    
    [timer setCurrentTime: 33];
    [game drawFrame];
    
    assertEquals((float) 33.0f, game.lastDrawTimeInMilliseconds);
}

- (void) testGameCallsDrawWithTheCorrectElapsedTime
{
    [timer setCurrentTime: 20];
    [game drawFrame];
    
    [timer setCurrentTime: 33];
    [game drawFrame];
    
    assertEquals((float) 13.0f, game.lastElapsedTimeInMilliseconds);
}

@end