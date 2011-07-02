//
//  MockEngine.h
//  Diamonds

#import "Engine.h"

@interface MockEngine : Engine 

@property (readonly) bool beginWasCalled;
@property (readonly) bool endWasCalled;

@end
