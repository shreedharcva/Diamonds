//
//  MockResourceManager.m
//  Diamonds

#import "MockResourceManager.h"
#import "MockTexture.h"

@implementation MockResourceManager
{
    MockTexture* lastTextureLoaded;
}

- (Texture*) loadTexture:(NSString *)name
{
    Texture* texture = [super loadTexture: name];
    lastTextureLoaded = (MockTexture*) texture;
    return texture;
}

- (void) setTextureFactory: (TextureFactory*) newFactory
{
    textureFactory = newFactory;    
}

- (MockTexture*) lastTexture
{
    return lastTextureLoaded;
}

@end
