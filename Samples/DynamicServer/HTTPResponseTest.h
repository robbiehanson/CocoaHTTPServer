#import <Foundation/Foundation.h>
#import "HTTPResponse.h"

@class HTTPConnection;

// 
// This class is a UnitTest for the delayResponseHeaders capability of HTTPConnection
// 

@interface HTTPResponseTest : NSObject <HTTPResponse>
{
	// Parents retain children, children do NOT retain parents
	
	__unsafe_unretained HTTPConnection *connection;
	dispatch_queue_t responseQueue;
	
	BOOL readyToSendResponseHeaders;
}

- (id)initWithConnection:(HTTPConnection *)connection;

@end
