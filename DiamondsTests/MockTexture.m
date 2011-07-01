//
//  MockTexture.m
//  Diamonds

#import "MockTexture.h"

@implementation MockTexture
@synthesize loadWasCalled;

- (void) load;
{
    loadWasCalled = true;
}

@end

@implementation MockTextureFactory

- (Texture*) create: (NSString*) name
{
    return [[MockTexture alloc] initWithName: name];
}

@end
