//
//  ResourceManager.m
//  Diamonds


#import "ResourceManager.h"
#import "Texture.h"

@implementation ResourceManager
{
    NSMutableDictionary* textures;
}

- (id) init
{
    self = [super init];
    if (self == nil)
    {
        return nil;
    }
    
    textureFactory = [TextureFactory new];
    textures = [NSMutableDictionary dictionary];
    
    return self;
}


- (int) numberOfTextures
{
    return [textures count];
}

- (Texture*) loadTexture: (NSString*) name
{
    Texture* texture = [textures objectForKey: name];
    if (texture == nil)
    {
        texture = [textureFactory create: name];
        [textures setObject: texture forKey: name];
        [texture load];
    }
    return texture;
}

@end
