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
}

- (id) initWithTextureName: (NSString*) name from: (ResourceManager*) resources
{
    self = [super init];
    if (self == nil)
        return nil;
    
    textureObject = [resources loadTexture: name];
    size = textureObject.size;

    return self;
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

- (void) drawIn: (SpriteBatch*) batch
{        
    [batch drawQuad: position size: size texture: textureObject];
}

@end
