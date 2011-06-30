//
//  Sprite.m
//  Diamonds

#import "Sprite.h"
#import "SpriteBatch.h"
#import "Texture.h"

@implementation Sprite
{
    Texture* textureObject;

    CGPoint position;
    CGSize size;
}

- (id) init
{
    self = [super init];
    if (self == nil)
        return nil;

    textureObject = [Texture new];
    [textureObject load];
    
    size = textureObject.size;
    
    return self;
}

- (void) moveTo: (CGPoint) newPosition
{
    position = newPosition;
}

- (void) resizeTo: (CGSize) newSize
{
    size = newSize;
}

- (void) drawUsingEngine: (Engine*) engine
{ 
    SpriteBatch* batch = [[SpriteBatch alloc] initWithEngine: engine];
        
    [batch begin];

    [self drawIn: batch];
    
    [batch end];
}

- (void) drawIn: (SpriteBatch*) batch
{        
    [batch drawQuad: position size: size texture: textureObject];
}

@end
