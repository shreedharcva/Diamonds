//
//  Game.m
//  Diamonds

#import "Game.h"
#import "Engine.h"

@implementation GameTime
{
    float milliseconds;
    float elapsedTimeInMilliseconds;
}

@synthesize milliseconds;
@synthesize elapsedTimeInMilliseconds;

- (void) setMilliseconds: (float) newMilliseconds
{
    elapsedTimeInMilliseconds = newMilliseconds - milliseconds;
    milliseconds = newMilliseconds;
}

+ (GameTime*) gameTime: (float) milliseconds
{
    GameTime* time = [GameTime new];
    [time setMilliseconds: milliseconds];
    return time;
}

@end

@implementation GameTimer
{
    GameTime* gameTime;
    NSDate* start;
}

- (id) init
{
    self = [super self];
    if (self == nil)
        return self;
    
    gameTime = [GameTime gameTime: 0];
    start = [NSDate date];
    
    return self;
}

- (float) milliseconds
{
    return -[start timeIntervalSinceNow] * 1000.0f;
}

- (GameTime*) getTime
{
    [gameTime setMilliseconds: [self milliseconds]];
    return gameTime;
}

@end

@implementation Game
{
    Engine* engine;
    GameTimer* timer;
}

@synthesize engine;

- (void) loadResources: (ResourceManager*) resources
{
}

- (void) update: (GameTime*) gameTime
{
}

- (void) draw: (GameTime*) gameTime
{
}

@end

@implementation Game (Private)

- (GameTimer*) timer
{
    if (timer == nil)
    {
        timer = [GameTimer new];
    }
    return timer;    
}

- (id) initWithEngine: (Engine*) theEngine
{
    self = [super init];
    if (self == nil)
        return nil; 

    engine = theEngine;
    
    return self;
}

- (void) updateFrame
{    
    [self update: [self.timer getTime]];    
}

- (void) drawFrame
{
    [self.engine beginFrame];
    [self draw: [self.timer getTime]];
    [self.engine endFrame];
}

@end
