//
//  ResourceManager.h
//  Diamonds

@class TextureFactory;
@class Texture;

@interface ResourceManager : NSObject 
{
    TextureFactory* textureFactory;
}

- (Texture*) loadTexture: (NSString*) name;

@end
