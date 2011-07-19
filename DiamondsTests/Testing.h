//
//  Testing.h
//  Diamonds

#import <SenTestingKit/SenTestingKit.h>

#define assertEquals(expected, actual) STAssertEquals(actual, expected, @"")
#define assertAlmostEquals(expected, actual) STAssertEqualsWithAccuracy(actual, expected, 0.0001f, @"")
#define assertTrue(expr) STAssertTrue(expr, @"");
#define assertFalse(expr) STAssertFalse(expr, @"");
#define assertNotNil(expr) STAssertNotNil(expr, @"");
#define assertNil(expr) STAssertNil(expr, @"");
#define assertEqualObjects(expected, actual) STAssertEqualObjects(actual, expected, @"");

#define assertIsKindOfClass(expected, expr) STAssertTrue([expr isKindOfClass: [expected class]], @"Wrong expected class");

#define assertThrows(expr) \
    {   \
    typedef void (^block_t)();  \
    block_t block = ^expr;   \
    STAssertThrows(block(), @""); \
    }   

typedef SenTestCase TestCase;