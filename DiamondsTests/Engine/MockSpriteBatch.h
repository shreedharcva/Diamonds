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

@interface SpriteDescriptorObject : NSObject

@property () CGPoint position;
@property () CGSize size;
@property () CGRect sourceRect;
@property (assign) Texture* texture;

@end

@interface MockSpriteBatch : SpriteBatch 

@property (readonly) int numberOfSpritesDrawn;
@property (readonly) SpriteDescriptor lastSprite;
@property (readonly) NSArray* sprites;

@end
