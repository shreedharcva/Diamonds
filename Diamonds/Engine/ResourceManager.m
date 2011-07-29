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
    return [self loadTexture: name from: nil];
}

- (Texture*) loadTexture: (NSString*) name from: (NSString*) folder
{
    NSString* key = [NSString stringWithFormat: @"%@/%@", folder, name];
    
    Texture* texture = [textures objectForKey: key];
    if (texture == nil)
    {
        texture = [textureFactory create: name];
        [textures setObject: texture forKey: key];
        [texture load: folder];
    }
    return texture;
}

@end
