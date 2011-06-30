//
//  Testing.h
//  Diamonds

#import <SenTestingKit/SenTestingKit.h>

#define assertEquals(expected, actual) STAssertEquals(actual, expected, @"")
#define assertTrue(expr) STAssertTrue(expr, @"");
#define assertEqualObjects(expected, actual) STAssertEqualObjects(actual, expected, @"");

#define assertThrows(expr) \
    {   \
    typedef void (^block_t)();  \
    block_t block = ^expr;   \
    STAssertThrows(block(), @""); \
    }   

typedef SenTestCase TestCase;