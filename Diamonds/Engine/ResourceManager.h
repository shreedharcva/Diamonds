//
//  ResourceManager.h
//  Diamonds

@class TextureFactory;
@class Texture;

@interface ResourceManager : NSObject 
{
    TextureFactory* textureFactory;
}

@property (readonly) int numberOfTextures;

- (Texture*) loadTexture: (NSString*) name;

@end
