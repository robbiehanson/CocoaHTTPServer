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

- (void)testSHA1Digest
{
    NSString *testString = @"I really love testing this stuff";
    NSData *testStringData = [testString dataUsingEncoding:NSASCIIStringEncoding];
    NSData *sha1Digest = [testStringData sha1Digest];
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"SHA1TestData" ofType:@"dat"];
    NSData *sha1DigestExpected = [NSData dataWithContentsOfFile:path];
    
    XCTAssert([sha1Digest isEqualToData:sha1DigestExpected], "SHA1 Digest does not match with the expected value.");
}

- (void)testHexStringValue
{
    NSString *testString = @"I'm quite enamoured by this testing stuff";
    NSData *testStringData = [testString dataUsingEncoding:NSASCIIStringEncoding];

    NSString *hexString = [testStringData hexStringValue];

    NSString *expectedHexString = @"49276d20717569746520656e616d6f7572656420627920746869732074657374696e67207374756666";
    
    XCTAssertEqualObjects(hexString, expectedHexString);
}

- (void)testBase64Encoding
{
    NSString *string = @"I'd love to encode and decode this string and be sure that the string is still the same!";
    NSData *data = [string dataUsingEncoding:NSASCIIStringEncoding];
    
    NSString *encodedString = [data base64Encoded];
    NSData *encodedData = [encodedString dataUsingEncoding:NSASCIIStringEncoding];
    
    NSData *decodedData = [encodedData base64Decoded];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSASCIIStringEncoding];
    
    XCTAssert([string isEqualToString:decodedString], "String changes after being encoded64 and decoded64.");
}

@end
