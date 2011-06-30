//
//  Testing.h
//  Diamonds

#import <SenTestingKit/SenTestingKit.h>

#define assertEquals(expected, actual) STAssertEquals(actual, expected, @"")
#define assertTrue(expr) STAssertTrue(expr, @"");
#define assertEqualObjects(expected, actual) STAssertEqualObjects(actual, expected, @"");

typedef SenTestCase TestCase;