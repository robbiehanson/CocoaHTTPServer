#import "HTTPResponseOk.h"

@implementation HTTPResponseOk

- (NSData *)readDataOfLength:(NSUInteger)length
{
    return nil;
}

- (BOOL)isDone
{
    return YES;
}

- (UInt64)contentLength
{
    return 0;
}

- (UInt64)offset
{
    return 0;
}

- (void)setOffset:(UInt64)offset
{
    
}

- (NSInteger)status
{
    return 200;
}

@end
