//
//  Texture.h
//  Diamonds

@class Texture;
@class TextureFactory;

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