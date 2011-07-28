//
//  Sprite.m
//  Diamonds

#import "Sprite.h"
#import "SpriteBatch.h"
#import "Texture.h"
#import "ResourceManager.h"

CGVector CGVectorMake(float x, float y)
{
    return CGPointMake(x, y);
}

@implementation Sprite
{
    Texture* texture;

    CGPoint position;
    CGSize size;
    CGRect sourceRectangle;
}

@synthesize size;
@synthesize position;
@synthesize texture;

- (id) initWithTexture: (Texture*) texture_
{
    self = [super init];
    if (self == nil)
        return nil;
    
    texture = texture_;
    size = texture_.size;
    sourceRectangle = CGRectMake(0.0, 0.0, 1.0, 1.0);
    
    return self;
}

- (void) setSourceRectangle: (CGRect) rect
{
    sourceRectangle.origin.x = rect.origin.x / texture.size.width;
    sourceRectangle.origin.y = rect.origin.y / texture.size.height;
    sourceRectangle.size.width = rect.size.width / texture.size.width;
    sourceRectangle.size.height = rect.size.height / texture.size.height;
}

- (void) moveTo: (CGPoint) newPosition
{
    position = newPosition;
}

- (void) moveBy: (CGVector) speed;
{
    position.x += speed.x;
    position.y += speed.y;
}

- (void) resizeTo: (CGSize) newSize
{
    size = newSize;
}

- (void) drawIn: (SpriteBatch*) batch
{        
    [batch drawQuad: position size: size texture: texture sourceRect: sourceRectangle];
}

@end
