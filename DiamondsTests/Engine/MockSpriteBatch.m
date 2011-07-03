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
    int spritesDrawn;
    
    CGPoint posiionOfTheLastSprite;
    CGSize sizeOfTheLastSprite;
    CGRect sourceRectangleOfTheLastSprite;
}

@synthesize spritesDrawn;
@synthesize posiionOfTheLastSprite;
@synthesize sizeOfTheLastSprite;
@synthesize sourceRectangleOfTheLastSprite;

- (void) drawQuad: (CGPoint) position size: (CGSize) size texture: (Texture*) texture sourceRect: (CGRect) source
{
    [super drawQuad: position size: size texture: texture sourceRect: source];
    
    ++spritesDrawn;
    
    posiionOfTheLastSprite = position;
    sizeOfTheLastSprite = size;
    sourceRectangleOfTheLastSprite = source;
}

@end

