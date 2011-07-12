//
//  MockTexture.m
//  Diamonds

#import "MockTexture.h"

@implementation MockTexture
{
    CGSize size;
}

@synthesize loadWasCalled;


- (void) load;
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

- (Texture*) create: (NSString*) name
{
    return [[MockTexture alloc] initWithName: name];
}


@end
