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
    sourceRectangle.origin = CGPointMake(0, 0);
    sourceRectangle.size = size;
    
    return self;
}

- (void) setSourceRectangle: (CGRect) rect
{
    sourceRectangle = rect;
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
