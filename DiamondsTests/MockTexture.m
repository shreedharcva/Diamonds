//
//  MockTexture.m
//  Diamonds

#import "MockTexture.h"

@implementation MockTexture
{
    CGSize size;
}

@synthesize loadWasCalled;


- (void) load: (NSString*) folder
{
    size = CGSizeMake(128, 128);
    loadWasCalled = true;
}

- (void) setSize: (CGSize) newSize
{
    size = newSize;    
}

- (CGSize) size
{
    return size;
}

@end

@implementation MockTextureFactory

- (Texture*) create: (NSString*) name
{
    Texture* texture = [[MockTexture alloc] initWithName: name];
    return texture;
}

@end
