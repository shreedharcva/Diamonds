//
//  SpriteBatch.h
//  Diamonds

#import "Sprite.h"

@class ShaderProgram;
@class Texture;
@class Engine;

@interface SpriteBatch : NSObject 

@property (readonly) Engine* engine;
@property (readonly) ShaderProgram* shaderProgram;

- (id) initWithEngine: (Engine*) theEngine;

- (bool) isEmpty;

- (void) begin;
- (void) end;

- (void) drawQuad: (CGPoint) position size: (CGSize) size texture: (Texture*) texture sourceRect: (CGRect) source;

@end