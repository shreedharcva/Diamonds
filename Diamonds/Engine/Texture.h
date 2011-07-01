//
//  Texture.h
//  Diamonds

#import <Foundation/Foundation.h>

@class Texture;
@class TextureFactory;

@interface ResourceManager : NSObject 
{
    TextureFactory* textureFactory;
}

- (Texture*) loadTexture: (NSString*) name;

@end

@interface Texture : NSObject 

@property (readonly, nonatomic) NSString* name;
@property (readonly, nonatomic) CGSize size;

- (id) initWithName: (NSString*) textureName;

- (void) load;
- (void) bind;

@end

@interface TextureFactory : NSObject 

- (Texture*) create: (NSString*) name;

@end