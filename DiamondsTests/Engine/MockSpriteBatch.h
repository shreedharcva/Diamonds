//
//  MockSpriteBatch.h
//  Diamonds

#import "Testing.h"
#import "Engine.h"
#import "SpriteBatch.h"

@interface MockSpriteBatch : SpriteBatch 

@property (readonly) int numberOfSpritesDrawn;

@property (readonly) CGPoint posiionOfTheLastSprite;
@property (readonly) CGSize sizeOfTheLastSprite;
@property (readonly) CGRect sourceRectangleOfTheLastSprite;

@end
