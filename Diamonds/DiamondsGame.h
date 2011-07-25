//
//  DiamondsGame.h
//  Diamonds

#import "Game.h"

@interface DiamondsGame : Game

- (void) moveLeft;
- (void) moveRight;

- (void) rotateLeft;
- (void) rotateRight;

- (void) drop;

@end
