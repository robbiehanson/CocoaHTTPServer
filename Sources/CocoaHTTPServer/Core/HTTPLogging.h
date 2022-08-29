/**
**/

#import <os/log.h>

// Define logging context for every log message coming from the HTTP server.
// The logging context can be extracted from the DDLogMessage from within the logging framework,
// which gives loggers, formatters, and filters the ability to optionally process them differently.

#define HTTP_LOG_CONTEXT 80

// Configure log levels.

#define HTTP_LOG_FLAG_ERROR   (1 << 0) // 0...00001
#define HTTP_LOG_FLAG_WARN    (1 << 1) // 0...00010
#define HTTP_LOG_FLAG_INFO    (1 << 2) // 0...00100
#define HTTP_LOG_FLAG_VERBOSE (1 << 3) // 0...01000

#define HTTP_LOG_LEVEL_OFF     0                                              // 0...00000
#define HTTP_LOG_LEVEL_ERROR   (HTTP_LOG_LEVEL_OFF   | HTTP_LOG_FLAG_ERROR)   // 0...00001
#define HTTP_LOG_LEVEL_WARN    (HTTP_LOG_LEVEL_ERROR | HTTP_LOG_FLAG_WARN)    // 0...00011
#define HTTP_LOG_LEVEL_INFO    (HTTP_LOG_LEVEL_WARN  | HTTP_LOG_FLAG_INFO)    // 0...00111
#define HTTP_LOG_LEVEL_VERBOSE (HTTP_LOG_LEVEL_INFO  | HTTP_LOG_FLAG_VERBOSE) // 0...01111

// Setup fine grained logging.
// The first 4 bits are being used by the standard log levels (0 - 3)
// 
// We're going to add tracing, but NOT as a log level.
// Tracing can be turned on and off independently of log level.

#define HTTP_LOG_FLAG_TRACE   (1 << 4) // 0...10000

// Setup the usual boolean macros.

#define HTTP_LOG_ERROR   (httpLogLevel & HTTP_LOG_FLAG_ERROR)
#define HTTP_LOG_WARN    (httpLogLevel & HTTP_LOG_FLAG_WARN)
#define HTTP_LOG_INFO    (httpLogLevel & HTTP_LOG_FLAG_INFO)
#define HTTP_LOG_VERBOSE (httpLogLevel & HTTP_LOG_FLAG_VERBOSE) != 0
#define HTTP_LOG_TRACE   (httpLogLevel & HTTP_LOG_FLAG_TRACE)

// Configure asynchronous logging.
// We follow the default configuration,
// but we reserve a special macro to easily disable asynchronous logging for debugging purposes.

#define HTTP_LOG_ASYNC_ENABLED   YES

#define HTTP_LOG_ASYNC_ERROR   ( NO && HTTP_LOG_ASYNC_ENABLED)
#define HTTP_LOG_ASYNC_WARN    (YES && HTTP_LOG_ASYNC_ENABLED)
#define HTTP_LOG_ASYNC_INFO    (YES && HTTP_LOG_ASYNC_ENABLED)
#define HTTP_LOG_ASYNC_VERBOSE (YES && HTTP_LOG_ASYNC_ENABLED)
#define HTTP_LOG_ASYNC_TRACE   (YES && HTTP_LOG_ASYNC_ENABLED)

// Define logging primitives.
/*
#define HTTPLogError(frmt, ...)    LOG_OBJC_MAYBE(HTTP_LOG_ASYNC_ERROR,   httpLogLevel, HTTP_LOG_FLAG_ERROR,  \
                                                  HTTP_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define HTTPLogWarn(frmt, ...)     LOG_OBJC_MAYBE(HTTP_LOG_ASYNC_WARN,    httpLogLevel, HTTP_LOG_FLAG_WARN,   \
                                                  HTTP_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define HTTPLogInfo(frmt, ...)     LOG_OBJC_MAYBE(HTTP_LOG_ASYNC_INFO,    httpLogLevel, HTTP_LOG_FLAG_INFO,    \
                                                  HTTP_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define HTTPLogVerbose(frmt, ...)  LOG_OBJC_MAYBE(HTTP_LOG_ASYNC_VERBOSE, httpLogLevel, HTTP_LOG_FLAG_VERBOSE, \
                                                  HTTP_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define HTTPLogTrace()             LOG_OBJC_MAYBE(HTTP_LOG_ASYNC_TRACE,   httpLogLevel, HTTP_LOG_FLAG_TRACE, \
                                                  HTTP_LOG_CONTEXT, @"%@", self, THIS_METHOD)

#define HTTPLogTrace2(frmt, ...)   LOG_OBJC_MAYBE(HTTP_LOG_ASYNC_TRACE,   httpLogLevel, HTTP_LOG_FLAG_TRACE, \
                                                  HTTP_LOG_CONTEXT, frmt, ##__VA_ARGS__)


#define HTTPLogCError(frmt, ...)      LOG_C_MAYBE(HTTP_LOG_ASYNC_ERROR,   httpLogLevel, HTTP_LOG_FLAG_ERROR,   \
                                                  HTTP_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define HTTPLogCWarn(frmt, ...)       LOG_C_MAYBE(HTTP_LOG_ASYNC_WARN,    httpLogLevel, HTTP_LOG_FLAG_WARN,    \
                                                  HTTP_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define HTTPLogCInfo(frmt, ...)       LOG_C_MAYBE(HTTP_LOG_ASYNC_INFO,    httpLogLevel, HTTP_LOG_FLAG_INFO,    \
                                                  HTTP_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define HTTPLogCVerbose(frmt, ...)    LOG_C_MAYBE(HTTP_LOG_ASYNC_VERBOSE, httpLogLevel, HTTP_LOG_FLAG_VERBOSE, \
                                                  HTTP_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define HTTPLogCTrace()               LOG_C_MAYBE(HTTP_LOG_ASYNC_TRACE,   httpLogLevel, HTTP_LOG_FLAG_TRACE, \
                                                  HTTP_LOG_CONTEXT, @"%@", self, __FUNCTION__)

#define HTTPLogCTrace2(frmt, ...)     LOG_C_MAYBE(HTTP_LOG_ASYNC_TRACE,   httpLogLevel, HTTP_LOG_FLAG_TRACE, \
                                                  HTTP_LOG_CONTEXT, frmt, ##__VA_ARGS__)

*/

#define HTTPLogError(frmt, ...)     os_log_with_type(OS_LOG_DEFAULT, OS_LOG_TYPE_ERROR, frmt, ##__VA_ARGS__)
#define HTTPLogVerbose(frmt, ...)   os_log_with_type(OS_LOG_DEFAULT, OS_LOG_TYPE_INFO, frmt, ##__VA_ARGS__)
#define HTTPLogWarn(frmt, ...)      os_log_with_type(OS_LOG_DEFAULT, OS_LOG_TYPE_INFO, frmt, ##__VA_ARGS__)
#define HTTPLogInfo(frmt, ...)      os_log_with_type(OS_LOG_DEFAULT, OS_LOG_TYPE_INFO, frmt, ##__VA_ARGS__)
#define HTTPLogTrace()              os_log(OS_LOG_DEFAULT, "Trace")
#define HTTPLogTrace2(frmt, ...)    os_log_with_type(OS_LOG_DEFAULT, OS_LOG_TYPE_INFO, frmt, ##__VA_ARGS__)
