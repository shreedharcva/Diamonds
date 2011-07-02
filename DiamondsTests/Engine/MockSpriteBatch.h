//
//  MockSpriteBatch.h
//  Diamonds

#import "Testing.h"
#import "Engine.h"
#import "SpriteBatch.h"

@interface MockSpriteBatch : SpriteBatch 

@property (readonly) int spritesDrawn;

@property (readonly) CGPoint posiionOfTheLastSprite;
@property (readonly) CGSize sizeOfTheLastSprite;

@end
