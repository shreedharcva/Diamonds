//
//  SpriteBatch.h
//  Diamonds

#import "Sprite.h"

@interface SpriteBatch : NSObject 

@property (readonly) Engine* engine;

- (id) initWithEngine: (Engine*) theEngine;

- (bool) isEmpty;

- (void) begin;
- (void) end;

- (void) drawQuad: (CGPoint) position size: (CGSize) size;

@end