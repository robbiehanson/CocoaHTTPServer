#import "../../Core/HTTPConnection.h"

@interface DAVConnection : HTTPConnection {
	id requestContentBody;
  NSOutputStream* requestContentStream;
}
@end
