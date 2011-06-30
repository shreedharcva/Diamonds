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
    Position lastDrawnSpritePosition;
}

- (int) spritesDrawn
{
    return spritesDrawn;
}

- (Position) lastDrawnSpritePosition
{
    return lastDrawnSpritePosition;
}

- (void) drawQuad: (Position) position
{
    ++spritesDrawn;
    lastDrawnSpritePosition = position;
}

@end

