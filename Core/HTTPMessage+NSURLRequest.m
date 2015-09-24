//
//  HTTPMessage+NSURLRequest.m
//  PartySnapper
//
//  Created by Maximilian Christ on 6/21/13.
//  Copyright (c) 2013 Boinx Software. All rights reserved.
//

#import "HTTPMessage+NSURLRequest.h"

@implementation HTTPMessage (NSURLRequest)

- (NSURLRequest *)URLRequest
{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.url];
	
	request.allHTTPHeaderFields = self.allHeaderFields;
	request.HTTPBody = self.body;
	
	return request;
}

@end
