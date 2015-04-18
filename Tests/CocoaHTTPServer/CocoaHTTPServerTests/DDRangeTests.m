//
//  DDRangeTests.m
//  CocoaHTTPServer
//
//  Created by Kent Humphries on 18/04/2015.
//  Copyright (c) 2015 Antonio Tanzola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "DDRange.h"

@interface DDRangeTests : XCTestCase

@property (nonatomic, readonly) DDRange range1;
@property (nonatomic, readonly) DDRange range2;

@end

// Note - this class is not really testing UINT64_MAX as
//        the type is not safe around these limits
@implementation DDRangeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDDMakeRange
{
    UInt64 location = 7;
    UInt64 length = 14;
    DDRange range = DDMakeRange(location, length);
    
    XCTAssertEqual(range.location, location);
    XCTAssertEqual(range.length, length);
}

- (void)testDDMaxRange
{
    UInt64 maxRange = DDMaxRange(self.range1);
    UInt64 expectedMaxRange = 21;
    
    XCTAssertEqual(maxRange, expectedMaxRange);
}

- (void)testLocationInRange
{
    XCTAssertFalse(DDLocationInRange(0, self.range1));
    XCTAssertFalse(DDLocationInRange(6, self.range1));
    XCTAssertTrue(DDLocationInRange(7, self.range1));
    XCTAssertTrue(DDLocationInRange(14, self.range1));
    XCTAssertTrue(DDLocationInRange(20, self.range1));
    XCTAssertFalse(DDLocationInRange(21, self.range1));
    XCTAssertFalse(DDLocationInRange(UINT64_MAX, self.range1));
}

- (void)testEqualRanges
{
    XCTAssertTrue(DDEqualRanges(self.range1, DDMakeRange(7, 14)));
    XCTAssertFalse(DDEqualRanges(self.range1, DDMakeRange(7, 13)));
    XCTAssertFalse(DDEqualRanges(self.range1, DDMakeRange(6, 14)));
    XCTAssertFalse(DDEqualRanges(self.range1, DDMakeRange(0, 0)));
    
    XCTAssertTrue(DDEqualRanges(DDMakeRange(0, 0), DDMakeRange(0, 0)));
}

- (void)testUnionRange
{
    DDRange unionRange = DDUnionRange(self.range1, self.range2);
    
    XCTAssertEqual(unionRange.location, 7);
    XCTAssertEqual(unionRange.length, 74);
}

- (void)testIntersectionRange
{
    DDRange intersectionRange = DDIntersectionRange(self.range1, self.range2);
    
    XCTAssertEqual(intersectionRange.location, 11);
    XCTAssertEqual(intersectionRange.length, 10);
    
}

- (void)testStringFromRange
{
    XCTAssertEqualObjects(DDStringFromRange(self.range1), @"{7, 14}");
    XCTAssertEqualObjects(DDStringFromRange(self.range2), @"{11, 70}");
}

- (void)testRangeFromString
{
    DDRange range = DDRangeFromString(@"{666, 6666}");
    
    XCTAssertEqual(range.location, 666);
    XCTAssertEqual(range.length, 6666);
}

- (void)testRangeCompare
{
    DDRange range1 = self.range1;
    DDRange range2 = self.range2;
    NSComparisonResult result = DDRangeCompare(&range1, &range2);
    XCTAssertEqual(result, NSOrderedAscending);

    result = DDRangeCompare(&range2, &range1);
    XCTAssertEqual(result, NSOrderedDescending);

    DDRange rangeEqualLocation1 = DDMakeRange(10, 100);
    DDRange rangeEqualLocation2 = DDMakeRange(10, 1000);
    
    result = DDRangeCompare(&rangeEqualLocation1, &rangeEqualLocation2);
    XCTAssertEqual(result, NSOrderedAscending);
    
    result = DDRangeCompare(&rangeEqualLocation2, &rangeEqualLocation1);
    XCTAssertEqual(result, NSOrderedDescending);
}

#pragma mark - NSValueDDRangeExtenstions

- (void)testValueWithDDRange
{
    NSValue *value = [NSValue valueWithDDRange:self.range1];
    
    XCTAssertEqualObjects([NSString stringWithUTF8String:value.objCType], @"{_DDRange=QQ}", @"Type of value should be '{_DDRange=QQ}'");

    DDRange extractedRange;
    [value getValue:&extractedRange];
    XCTAssertTrue(DDEqualRanges(extractedRange, self.range1));
}

- (void)testDDRangeValue
{
    NSValue *value = [NSValue valueWithDDRange:self.range1];
    XCTAssertTrue(DDEqualRanges([value ddrangeValue], self.range1));
}

- (void)testDDRangeCompare
{
    NSValue *range1 = [NSValue valueWithDDRange:self.range1];
    NSValue *range2 = [NSValue valueWithDDRange:self.range2];
    NSComparisonResult result = [range1 ddrangeCompare:range2];
    XCTAssertEqual(result, NSOrderedAscending);
    
    result = [range2 ddrangeCompare:range1];
    XCTAssertEqual(result, NSOrderedDescending);
    
    NSValue *rangeEqualLocation1 = [NSValue valueWithDDRange:DDMakeRange(10, 100)];
    NSValue *rangeEqualLocation2 = [NSValue valueWithDDRange:DDMakeRange(10, 1000)];
    
    result = [rangeEqualLocation1 ddrangeCompare:rangeEqualLocation2];
    XCTAssertEqual(result, NSOrderedAscending);
    
    result = [rangeEqualLocation2 ddrangeCompare:rangeEqualLocation1];
    XCTAssertEqual(result, NSOrderedDescending);
}

#pragma mark - Convenience Properties

- (DDRange)range1
{
    UInt64 location1 = 7;
    UInt64 length1 = 14;
    return DDMakeRange(location1, length1);
}

- (DDRange)range2
{
    UInt64 location1 = 11;
    UInt64 length1 = 70;
    return DDMakeRange(location1, length1);
}

@end
