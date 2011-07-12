//
//  TestResourceManager.h
//  Diamonds

#import "Testing.h"

#import "ResourceManager.h"

@class MockResourceManager;

@interface TestResourceManager : TestCase
{
    MockResourceManager* resources;
}

@end