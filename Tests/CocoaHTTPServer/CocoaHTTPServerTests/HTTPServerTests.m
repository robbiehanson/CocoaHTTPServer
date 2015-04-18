
#import <XCTest/XCTest.h>
#import "HTTPServer.h"

@interface HTTPServerTests : XCTestCase

@property (nonatomic, strong) HTTPServer *server;

@end

@implementation HTTPServerTests

- (void)setUp
{
    [super setUp];
    self.server = [[HTTPServer alloc] init];
}

- (void)tearDown
{
    [super tearDown];
    if (self.server.isRunning) {
        [self.server stop:NO];
    }
}

- (void)testHTTPServerStartsUp
{
    NSError *error;
    [self.server start:&error];
    
    XCTAssert(error == nil, @"An error occured while trying to start the server.");
    XCTAssert(self.server.isRunning, @"Server is not running after having been started.");
}

- (void)testHTTPServerReceiveIncomingConnection
{
    NSError *error;
    [self.server setPort:8888];
    [self.server start:&error];
    
    XCTAssert(self.server.numberOfHTTPConnections == 0, @"Number of connection is not 0 before any connections are created to the server.");
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://:8888"]];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:nil];
    [connection start];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"3 seconds timeout to allow the server to process the connection."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError *error) {
         XCTAssert(self.server.numberOfHTTPConnections == 1, @"NSURLConnection did not connect to the server.");
    }];
}

- (void)testHTTPServerReceive4MultipleIncomingConnections
{
    NSError *error;
    [self.server setPort:8888];
    [self.server start:&error];
    
    XCTAssert(self.server.numberOfHTTPConnections == 0, @"Number of connection is not 0 before any connections are created to the server.");
    
    const NSUInteger numberOfParallerConnections = 4;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://:8888"]];
    NSMutableArray *connections = [NSMutableArray array];//we store them to keep them alive until the test is complete
    for (NSUInteger i = 0; i < numberOfParallerConnections; i++) {
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:nil];
        [connection start];
        [connections addObject:connection];
    }
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"4 seconds timeout to allow the server to process the connection."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:20.0f handler:^(NSError *error) {
         XCTAssert(self.server.numberOfHTTPConnections == numberOfParallerConnections, @"NSURLConnection did not connect to the server.");
    }];
}


@end
