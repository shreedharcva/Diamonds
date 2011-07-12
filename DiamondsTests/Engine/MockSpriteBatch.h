//
//  MockSpriteBatch.h
//  Diamonds

#import "Testing.h"
#import "Engine.h"
#import "SpriteBatch.h"

typedef struct SpriteDescriptor
{    
    CGPoint position;
    CGSize size;
    CGRect sourceRect;
    
    Texture* texture;
} 
SpriteDescriptor;

@interface MockSpriteBatch : SpriteBatch 

@property (readonly) int numberOfSpritesDrawn;
@property (readonly) SpriteDescriptor lastSprite;

@end
