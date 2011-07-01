//
//  MockTexture.h
//  Diamonds

#import "Texture.h"

@interface MockTexture : Texture

@property (readonly) bool loadWasCalled;

@end

@interface MockTextureFactory : TextureFactory 
@end