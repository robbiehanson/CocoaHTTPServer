//
//  HTTPErrorResponse.m
//  ScreenOnWall
//
//  Created by Dirk-Willem van Gulik on 04-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HTTPErrorResponse.h"

@implementation HTTPErrorResponse
@synthesize _status = status;

-(id)initWithErrorCode:(int)httpErrorCode
{
    if (!(self = [super init]))
        return nil;
    
    _status = httpErrorCode;

    return self;
}

- (UInt64) contentLength {
    return 0;
}

- (UInt64) offset {
    return 0;
}

- (void)setOffset:(UInt64)offset {
    ;
}

- (NSData*) readDataOfLength:(NSUInteger)length {
    return nil;
}

- (BOOL) isDone {
    return YES;
}

- (NSInteger) status {
    return _status;
}
@end
