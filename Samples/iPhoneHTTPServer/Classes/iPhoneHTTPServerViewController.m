#import "iPhoneHTTPServerViewController.h"
#import "iPhoneHTTPServerAppDelegate.h"
#import "HTTPServer.h"

@implementation iPhoneHTTPServerViewController

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    iPhoneHTTPServerAppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    HTTPServer * httpServer = (HTTPServer*) appDelegate.httpServer;
    NSString* server = [NSString stringWithFormat:@"http://127.0.0.1:%hu", httpServer.listeningPort];
    
    NSURL *myURL = [NSURL URLWithString: [NSString stringWithFormat: @"%@", server]];
    [[UIApplication sharedApplication] openURL:myURL];
}

@end
