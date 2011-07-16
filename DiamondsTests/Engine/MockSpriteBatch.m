//
//  MockSpriteBatch.m
//  Diamonds

#import "MockSpriteBatch.h"

#import "Sprite.h"
#import "SpriteBatch.h"
#import "Engine.h"

#import "MockEngine.h"

@implementation SpriteDescriptorObject
{
    CGPoint position;
    CGSize size;
    CGRect sourceRect;
    
    Texture* texture;    
}

@synthesize position;
@synthesize size;
@synthesize sourceRect;
@synthesize texture;

@end 


@implementation MockSpriteBatch
{
    int numberOfSpritesDrawn;
    
    NSMutableArray* sprites;
    SpriteDescriptor lastSprite;
}

@synthesize numberOfSpritesDrawn;
@synthesize lastSprite;
@synthesize sprites;

- (void) drawQuad: (CGPoint) position size: (CGSize) size texture: (Texture*) texture sourceRect: (CGRect) source
{
    if (sprites == nil)
    {
        sprites = [NSMutableArray new];
    }
    
    [super drawQuad: position size: size texture: texture sourceRect: source];
    
    ++numberOfSpritesDrawn;
    
    lastSprite.texture = texture;
    lastSprite.position = position;
    lastSprite.size = size;
    lastSprite.sourceRect = source;
    
    SpriteDescriptorObject* descriptor = [SpriteDescriptorObject new]; 

    descriptor.texture = texture;
    descriptor.position = position;
    descriptor.size = size;
    descriptor.sourceRect = source;
    
    [sprites addObject: descriptor];
}

@end

