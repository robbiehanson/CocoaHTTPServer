//
//  CocoaHTTPServerTests.m
//  CocoaHTTPServerTests
//
//  Created by Antonio Tanzola on 18/04/2015.
//  Copyright (c) 2015 Antonio Tanzola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "DDData.h"

@interface CocoaHTTPServerTests : XCTestCase

@end

@implementation CocoaHTTPServerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMD5Digest
{
    NSString *testString = @"I love testing this stuff";
    NSData *testStringData = [testString dataUsingEncoding:NSASCIIStringEncoding];
    NSData *md5Digest = [testStringData md5Digest];

    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"MD5TestData" ofType:@"dat"];
    NSData *md5DigestExpected = [NSData dataWithContentsOfFile:path];
    
    XCTAssert([md5Digest isEqualToData:md5DigestExpected], "MD5 Digest does not match with the expected value.");
}

@end
