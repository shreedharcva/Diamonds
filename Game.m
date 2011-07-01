//
//  Game.m
//  Diamonds

#import "Game.h"

@class Engine;

@implementation Game
{
    Engine* engine;
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

@end
