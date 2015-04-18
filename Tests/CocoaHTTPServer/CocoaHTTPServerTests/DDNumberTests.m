
#import <XCTest/XCTest.h>
#import "DDNumber.h"

@interface DDNumberTests : XCTestCase
@end

@implementation DDNumberTests

- (void)testParseStringIntoSInt64
{
    SInt64 int64ToTest = -4343264723;
    
    SInt64 int64Tested;
    NSString *int64String = [NSString stringWithFormat:@"%ld", (long)int64ToTest];
    XCTAssert([NSNumber parseString:int64String intoSInt64:&int64Tested], @"Parsing of string containing SInt64 failed.");
    
    XCTAssert(int64Tested == int64ToTest, @"Parsing of string containing SInt64 is not correct.");
}

- (void)testParseStringIntoUInt64
{
    UInt64 intU64ToTest = 62324723;
    
    UInt64 intU64Tested;
    NSString *intU64String = [NSString stringWithFormat:@"%ld", (long)intU64ToTest];
    XCTAssert([NSNumber parseString:intU64String intoUInt64:&intU64Tested], @"Parsing of string containing UInt64 failed.");
    
    XCTAssert(intU64Tested == intU64ToTest, @"Parsing of string containing UInt64 is not correct.");
}

- (void)testParseStringIntoNSInteger
{
    NSInteger integerToTest = -4343264723;
    
    NSInteger integerTested;
    NSString *integerString = [NSString stringWithFormat:@"%ld", (long)integerToTest];
    XCTAssert([NSNumber parseString:integerString intoNSInteger:&integerTested], @"Parsing of string containing NSInteger failed.");
    
    XCTAssert(integerTested == integerToTest, @"Parsing of string containing NSInteger is not correct.");
}

- (void)testParseStringIntoNSUInteger
{
    NSInteger positiveIntegerToTest = 36473264723;
    
    NSInteger positiveIntegerTested;
    NSString *positiveIntegerString = [NSString stringWithFormat:@"%ld", (long)positiveIntegerToTest];
    XCTAssert([NSNumber parseString:positiveIntegerString intoNSInteger:&positiveIntegerTested], @"Parsing of string containing NSUInteger failed.");
    
    XCTAssert(positiveIntegerTested == positiveIntegerToTest, @"Parsing of string containing NSUInteger is not correct.");
}

@end
