//
//  TestGame.m
//  Diamonds

#import "TestGame.h"

#import "Game.h"
#import "Engine.h"
#import "MockEngine.h"

@interface MockGame : Game 

@property (readonly) bool drawWasCalled;

@end

@implementation MockGame
{
    bool drawWasCalled;
}

@synthesize drawWasCalled;

- (void) draw
{
    drawWasCalled = true;
}

@end


@interface TestGame : TestCase 
@end

@implementation TestGame

- (void) setUp
{
    [super setUp];
}

- (void) testGameIsCreatedWithAnEngine
{
    Engine* engine = [Engine new]; 
    Game* game = [[Game alloc] initWithEngine: engine];

    assertEqualObjects(engine, game.engine);
}

- (void) testGameCallsBeginAndEndOnTheEngineWhenDrawFrameIsCalled
{
    MockEngine* engine = [MockEngine new]; 
    Game* game = [[Game alloc] initWithEngine: engine];
    
    [game drawFrame];

    assertTrue(engine.beginWasCalled);
    assertTrue(engine.endWasCalled);
}

- (void) testGameCallsDrawOnTheSubClassWhenDrawFrameIsCalled
{
    MockEngine* engine = [MockEngine new]; 
    MockGame* game = [[MockGame alloc] initWithEngine: engine];
    
    [game drawFrame];
    
    assertTrue(game.drawWasCalled);
}

@end
