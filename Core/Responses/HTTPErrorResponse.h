//
//  HTTPErrorResponse.h
//  ScreenOnWall
//
//  Created by Dirk-Willem van Gulik on 04-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HTTPResponse.h"

@interface HTTPErrorResponse : NSObject <HTTPResponse> {
    NSInteger _status;
}
@property (assign) NSInteger _status;

- (id)initWithErrorCode:(int)httpErrorCode;

@end
