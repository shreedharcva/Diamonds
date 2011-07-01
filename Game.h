//
//  Game.h
//  Diamonds

@class Engine;

@interface Game : NSObject

- (id)initWithEngine: (Engine*) engine;

@property (readonly, nonatomic) Engine* engine;

@end
