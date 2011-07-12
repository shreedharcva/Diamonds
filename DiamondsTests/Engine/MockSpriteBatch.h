//
//  MockSpriteBatch.h
//  Diamonds

#import "Testing.h"
#import "Engine.h"
#import "SpriteBatch.h"

typedef struct SpriteDescriptor
{    
    CGPoint position;

    Texture* texture;
} 
SpriteDescriptor;

@interface MockSpriteBatch : SpriteBatch 

@property (readonly) int numberOfSpritesDrawn;
@property (readonly) SpriteDescriptor lastSprite;

@property (readonly) CGPoint posiionOfTheLastSprite;
@property (readonly) CGSize sizeOfTheLastSprite;
@property (readonly) CGRect sourceRectangleOfTheLastSprite;

@end
