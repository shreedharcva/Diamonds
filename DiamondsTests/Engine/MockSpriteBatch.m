//
//  MockSpriteBatch.m
//  Diamonds

#import "MockSpriteBatch.h"

#import "Sprite.h"
#import "SpriteBatch.h"
#import "Engine.h"

#import "MockEngine.h"

@implementation MockSpriteBatch
{
    int numberOfSpritesDrawn;
    
    SpriteDescriptor lastSprite;
    
}

@synthesize numberOfSpritesDrawn;
@synthesize lastSprite;

- (void) drawQuad: (CGPoint) position size: (CGSize) size texture: (Texture*) texture sourceRect: (CGRect) source
{
    [super drawQuad: position size: size texture: texture sourceRect: source];
    
    ++numberOfSpritesDrawn;
    
    lastSprite.texture = texture;
    lastSprite.position = position;
    lastSprite.size = size;
    lastSprite.sourceRect = source;
}

@end

