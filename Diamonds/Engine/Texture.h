//
//  Texture.h
//  Diamonds

@class Texture;
@class TextureFactory;

@interface Texture : NSObject 
{
    NSString* name;
    CGSize size;
}

@property (readonly, nonatomic) NSString* name;
@property (readonly, nonatomic) CGSize size;

- (id) initWithName: (NSString*) textureName;

- (void) load: (NSString*) folder;
- (void) bind;

@end

@interface TextureFactory : NSObject 

- (Texture*) create: (NSString*) name;

@end