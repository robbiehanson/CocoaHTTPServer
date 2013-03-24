#import "HTTPResponseTest.h"
#import "HTTPConnection.h"
#import "HTTPLogging.h"

// Does ARC support support GCD objects?
// It does if the minimum deployment target is iOS 6+ or Mac OS X 8+

#if TARGET_OS_IPHONE

  // Compiling for iOS

  #if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000 // iOS 6.0 or later
    #define NEEDS_DISPATCH_RETAIN_RELEASE 0
  #else                                         // iOS 5.X or earlier
    #define NEEDS_DISPATCH_RETAIN_RELEASE 1
  #endif

#else

  // Compiling for Mac OS X

  #if MAC_OS_X_VERSION_MIN_REQUIRED >= 1080     // Mac OS X 10.8 or later
    #define NEEDS_DISPATCH_RETAIN_RELEASE 0
  #else
    #define NEEDS_DISPATCH_RETAIN_RELEASE 1     // Mac OS X 10.7 or earlier
  #endif

#endif

// Log levels: off, error, warn, info, verbose
// Other flags: trace
static const int httpLogLevel = HTTP_LOG_LEVEL_OFF; // | HTTP_LOG_FLAG_TRACE;

// 
// This class is a UnitTest for the delayResponseHeaders capability of HTTPConnection
// 

@interface HTTPResponseTest (PrivateAPI)
- (void)doAsyncStuff;
- (void)asyncStuffFinished;
@end


@implementation HTTPResponseTest

- (id)initWithConnection:(HTTPConnection *)parent
{
	if ((self = [super init]))
	{
		HTTPLogTrace();
		
		connection = parent;
		responseQueue = dispatch_queue_create("HTTPResponseTest", NULL);
		
		readyToSendResponseHeaders = NO;
		
		[self doAsyncStuff];
	}
	return self;
}

- (void)doAsyncStuff
{
	HTTPLogTrace();
	
	dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
	dispatch_async(concurrentQueue, ^{ @autoreleasepool {
		
		// Simulate a long-running asynchronous task...
		[NSThread sleepForTimeInterval:5.0];
		
		// Simulate completion callback
		dispatch_async(responseQueue, ^{ @autoreleasepool {
			
			[self asyncStuffFinished];
		}});
	}});
}

- (void)asyncStuffFinished
{
	// This method is executed on the responseQueue
	
	HTTPLogTrace();
	
	// Enable flag that indicates we have enough information to send the response headers.
	readyToSendResponseHeaders = YES;
	
	// Then notify the connection that "something has changed".
	// The 'responseHasAvailableData:' method is thread-safe.
	// It knows what state the connection is in, and will "do the right thing".
	// In this case, it will requery us via delayResponseHeaders to see if it can send the headers yet.
	[connection responseHasAvailableData:self];
}

- (BOOL)delayResponseHeaders
{
	HTTPLogTrace2(@"%@[%p] %@ -> %@", THIS_FILE, self, THIS_METHOD, (readyToSendResponseHeaders ? @"NO" : @"YES"));
	
	__block BOOL delayResponseHeaders = NO;
	
	dispatch_sync(responseQueue, ^{
		
		delayResponseHeaders = !readyToSendResponseHeaders;
	});
	
	return delayResponseHeaders;
}

- (void)connectionDidClose
{
	HTTPLogTrace();
	
	dispatch_sync(responseQueue, ^{
		connection = nil;
	});
}

- (UInt64)contentLength
{
	HTTPLogTrace();
	
	__block UInt64 contentLength = 0;
	
	dispatch_sync(responseQueue, ^{
		
		// Normal code would go here
		contentLength = 0;
	});
	
	return contentLength;
}

- (UInt64)offset
{
	HTTPLogTrace();
	
	__block UInt64 offset = 0;
	
	dispatch_sync(responseQueue, ^{
		
		// Normal code would go here
		offset = 0;
	});
	
	return offset;
}

- (void)setOffset:(UInt64)offset
{
	HTTPLogTrace();
	
	dispatch_sync(responseQueue, ^{
		
		// Normal code would go here
	});
}

- (NSData *)readDataOfLength:(NSUInteger)length
{
	HTTPLogTrace();
	
	__block NSData *data = nil;
	
	dispatch_sync(responseQueue, ^{
		
		// Normal code would go here
	});
	
	return data;
}

- (BOOL)isDone
{
	HTTPLogTrace();
	
	__block BOOL isDone = NO;
	
	dispatch_sync(responseQueue, ^{
		
		// Normal code would go here
		isDone = YES;
	});
	
	return isDone;
}

- (void)dealloc
{
	HTTPLogTrace();
	
	#if NEEDS_DISPATCH_RETAIN_RELEASE
	dispatch_release(responseQueue);
	#endif
}

@end
