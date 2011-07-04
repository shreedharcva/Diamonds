//
//  Game.m
//  Diamonds

#import "Game.h"

#import "Engine.h"

@implementation GameTime
{
    float elapsedTimeInMilliseconds;
    float milliseconds;
}

- (float) milliseconds
{
    return milliseconds;
}

- (float) elapsedTimeInMilliseconds
{
    return elapsedTimeInMilliseconds;
}

- (void) setTime: (float) newMilliseconds
{
    elapsedTimeInMilliseconds = newMilliseconds - milliseconds;
    milliseconds = newMilliseconds;    
}

@end

@implementation GameTimer
{
    GameTime* time;
    NSDate* start;
}

- (id) init
{
    self = [super init];
    if (self == nil)
        return nil;
    
    time = [GameTime new];
    start = [NSDate date];
    
    return self;
}

- (float) milliseconds
{
    return -[start timeIntervalSinceNow] * 1000.0f;
}

- (GameTime*) getTime
{
    [time setTime: [self milliseconds]];
    return time;    
}

@end


@implementation Game
{
    Engine* engine;
    GameTimer* timer;
}

@synthesize engine;

- (id) initWithEngine: (Engine*) theEngine
{
    self = [super init];
    if (self == nil)
        return nil;
    
    engine = theEngine;
    
    return self;
}

- (GameTimer*) timer
{
    if (timer == nil)
    {
        timer = [GameTimer new];
    }
    return timer;
}

- (void) loadResources: (ResourceManager*) manager
{
}

- (void) update: (GameTime*) gameTime
{
}

- (void) draw: (GameTime*) gameTime
{
}

- (void) updateFrame
{
    [self update: [[self timer] getTime]];
}

- (void) drawFrame
{
    [self.engine beginFrame];
    [self draw: [[self timer] getTime]];
    [self.engine endFrame];    
}

@end
