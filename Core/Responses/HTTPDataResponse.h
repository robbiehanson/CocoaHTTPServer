#import <Foundation/Foundation.h>
#import "EEHTTPResponse.h"


@interface HTTPDataResponse : NSObject <EEHTTPResponse>
{
	NSUInteger offset;
	NSData *data;
}

- (id)initWithData:(NSData *)data;

@end
