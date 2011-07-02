//
//  MockEngine.m
//  Diamonds

#import "MockEngine.h"

@implementation MockEngine
{
    bool beginWasCalled;
    bool endWasCalled;
}

@synthesize beginWasCalled;
@synthesize endWasCalled;

- (void) beginFrame
{
    beginWasCalled = true;
}

- (void) endFrame
{    
    endWasCalled = true;    
}

@end
