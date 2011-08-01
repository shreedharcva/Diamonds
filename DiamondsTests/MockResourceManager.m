//
//  MockResourceManager.m
//  Diamonds

#import "MockResourceManager.h"
#import "MockTexture.h"

@implementation MockResourceManager
{
    MockTexture* lastTextureLoaded;
}

- (id) init
{
    self = [super init];
    if (self == nil)
        return nil;
    
    [self setTextureFactory: [MockTextureFactory new]];

    return self;
}

- (Texture*) loadTexture: (NSString*) name from: (NSString*) folder
{
    Texture* texture = [super loadTexture: name from: folder];
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

- (MockTextureFactory*) textureFactory
{
    return (MockTextureFactory*) textureFactory;
}

@end
