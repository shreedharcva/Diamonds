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

@property (readonly) int spritesDrawn;

@property (readonly) CGPoint posiionOfTheLastSprite;
@property (readonly) CGSize sizeOfTheLastSprite;

@end
