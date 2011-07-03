//
//  Sprite.m
//  Diamonds

#import "Sprite.h"
#import "SpriteBatch.h"
#import "Texture.h"
#import "ResourceManager.h"

@implementation Sprite
{
    Texture* textureObject;

    CGPoint position;
    CGSize size;
    CGRect sourceRectangle;
}

@synthesize size;

- (id) initWithTexture: (Texture*) texture
{
    self = [super init];
    if (self == nil)
        return nil;
    
    textureObject = texture;
    size = textureObject.size;
    sourceRectangle = CGRectMake(0.0, 0.0, 1.0, 1.0);
    
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

- (void) setSourceRectangle: (CGRect) rect
{
    sourceRectangle.origin.x = rect.origin.x / textureObject.size.width;
    sourceRectangle.origin.y = rect.origin.y / textureObject.size.height;
    sourceRectangle.size.width = rect.size.width / textureObject.size.width;
    sourceRectangle.size.height = rect.size.height / textureObject.size.height;
}

- (void) drawIn: (SpriteBatch*) batch
{        
    [batch drawQuad: position size: size texture: textureObject sourceRect: sourceRectangle];
}

@end
