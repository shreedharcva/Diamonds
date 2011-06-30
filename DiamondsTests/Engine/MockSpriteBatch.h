//
//  MockSpriteBatch.h
//  Diamonds

#import "Testing.h"
#import "Engine.h"
#import "SpriteBatch.h"


@interface MockEngine: Engine
@end

@interface SpriteBatch (Testing)

@property (readonly) int spritesDrawn;

@end

@interface MockSpriteBatch : SpriteBatch 

- (int) spritesDrawn;

- (Position) lastDrawnSpritePosition;

@end
