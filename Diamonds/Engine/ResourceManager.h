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
- (Texture*) loadTexture: (NSString*) name from: (NSString*) folder;

@end
