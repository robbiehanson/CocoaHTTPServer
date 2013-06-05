#import "MyHTTPConnection.h"
#import "HTTPLogging.h"
#import "DDKeychain.h"

// Log levels: off, error, warn, info, verbose
// Other flags: trace
static const int httpLogLevel = HTTP_LOG_LEVEL_WARN; // | HTTP_LOG_FLAG_TRACE;


@implementation MyHTTPConnection

/**
 * Overrides HTTPConnection's method
**/
- (BOOL)isSecureServer
{
	HTTPLogTrace();
	
	// Create an HTTPS server (all connections will be secured via SSL/TLS)
	return YES;
}

/**
 * Overrides HTTPConnection's method
 * 
 * This method is expected to returns an array appropriate for use in kCFStreamSSLCertificates SSL Settings.
 * It should be an array of SecCertificateRefs except for the first element in the array, which is a SecIdentityRef.
**/
- (NSArray *)sslIdentityAndCertificates
{
	HTTPLogTrace();
	
    // Create SSL identity & cert in dynamic manner
    NSArray *result = [DDKeychain SSLIdentityAndCertificates];
	if([result count] == 0)
	{
		[DDKeychain createNewIdentity];
		return [DDKeychain SSLIdentityAndCertificates];
	}
	return result;
    
    // Or, you can import existing server.p12 file.
    // Refers to http://stackoverflow.com/questions/12513291/ios-mutual-authentication
    SecIdentityRef identityApp = nil;
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *myFilePath = [bundlePath stringByAppendingPathComponent:@"server.p12"];
    NSData *PKCS12Data = [NSData dataWithContentsOfFile:myFilePath];
    
    CFDataRef inPKCS12Data = (__bridge CFDataRef)PKCS12Data;
    CFStringRef password = CFSTR("password");
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import(inPKCS12Data, options, &items);
    CFRelease(options);
    CFRelease(password);
    if (securityError == errSecSuccess) {
        HTTPLogVerbose(@"Success opening p12 certificate. Items: %ld", CFArrayGetCount(items));
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
    } else {
        HTTPLogInfo(@"Error opening Certificate.");
    }
    return [NSArray arrayWithObject:(__bridge id)identityApp];
}

@end
