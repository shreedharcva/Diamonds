//
//  TestGame.m
//  Diamonds

#import "TestGame.h"
#import "Game.h"
#import "Engine.h"
            
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

@end
