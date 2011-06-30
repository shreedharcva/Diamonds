//
//  SpriteBatch.h
//  Diamonds

#import "Sprite.h"

@class ShaderProgram;
@class Texture;

@interface SpriteBatch : NSObject 
{
    @public
    ShaderProgram* shaderProgram;
}

@property (readonly) Engine* engine;
@property (readonly) ShaderProgram* shaderProgram;

- (id) initWithEngine: (Engine*) theEngine;

- (bool) isEmpty;

- (void) begin;
- (void) end;

- (void) drawQuad: (CGPoint) position size: (CGSize) size texture: (Texture*) texture;

@end