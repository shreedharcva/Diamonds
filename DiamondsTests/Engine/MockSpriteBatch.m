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
}

@synthesize spritesDrawn;
@synthesize posiionOfTheLastSprite;
@synthesize sizeOfTheLastSprite;

- (void) drawQuad: (CGPoint) position size: (CGSize) size texture: (Texture*)texture
{
    [super drawQuad: position size: size texture: texture];
    
    ++spritesDrawn;
    
    posiionOfTheLastSprite = position;
    sizeOfTheLastSprite = size;
}

@end

