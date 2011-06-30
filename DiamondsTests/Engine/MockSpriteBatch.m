//
//  MockSpriteBatch.m
//  Diamonds

#import "MockSpriteBatch.h"

#import "Sprite.h"
#import "SpriteBatch.h"
#import "Engine.h"

@implementation MockEngine
@end

@implementation SpriteBatch (Testing)

- (int) spritesDrawn
{
    return 0;
}

@end

@implementation MockSpriteBatch
{
    int spritesDrawn;
    
    CGPoint posiionOfTheLastSprite;
    CGSize sizeOfTheLastSprite;
}

@synthesize spritesDrawn;
@synthesize posiionOfTheLastSprite;
@synthesize sizeOfTheLastSprite;

- (void) drawQuad: (CGPoint) position size: (CGSize) size;
{
    [super drawQuad: position size: size];
    
    ++spritesDrawn;
    
    posiionOfTheLastSprite = position;
    sizeOfTheLastSprite = size;
}

@end

