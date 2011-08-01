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
{
    CGSize textureSize;
}

- (id) init
{
    self = [super init];
    if (self == nil)
        return nil;
    
    textureSize = CGSizeMake(128, 128);
    
    return self;
}

- (void) setTextureSize: (CGSize) size_
{
    textureSize = size_;
}

- (Texture*) create: (NSString*) name
{
    MockTexture* texture = [[MockTexture alloc] initWithName: name];
    [texture setSize: textureSize];
    return texture;
}

@end
