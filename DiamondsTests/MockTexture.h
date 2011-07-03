//
//  MockTexture.h
//  Diamonds

#import "Texture.h"

@interface MockTexture : Texture

@property (readonly) bool loadWasCalled;

- (void) setSize: (CGSize) newSize;

@end

@interface MockTextureFactory : TextureFactory 
@end