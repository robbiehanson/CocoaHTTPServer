#import <Foundation/Foundation.h>
#import "EEHTTPResponse.h"


@interface HTTPRedirectResponse : NSObject <EEHTTPResponse>
{
	NSString *redirectPath;
}

- (id)initWithPath:(NSString *)redirectPath;

@end
