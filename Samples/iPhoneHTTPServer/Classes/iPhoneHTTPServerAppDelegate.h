#import <UIKit/UIKit.h>
#import "MTAudioPlayer.h"

@class iPhoneHTTPServerViewController;
@class HTTPServer;

@interface iPhoneHTTPServerAppDelegate : NSObject <UIApplicationDelegate>
{
	HTTPServer *httpServer;
    MTAudioPlayer * audioPlayer;
	
	UIWindow *window;
	iPhoneHTTPServerViewController *viewController;
    
    UIBackgroundTaskIdentifier bgTask;
}

@property (nonatomic, retain) HTTPServer *httpServer;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iPhoneHTTPServerViewController *viewController;

@end

