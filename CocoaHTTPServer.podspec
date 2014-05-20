Pod::Spec.new do |s|
  s.name = 'CocoaHTTPServer'
  s.version = '2.4'
  s.license = 'BSD'
  s.summary = 'A small, lightweight, embeddable HTTP server for Mac OS X or iOS applications.'
  s.homepage = 'https://github.com/gpinigin/CocoaHTTPServer'
  s.authors = { 'Gleb Pinigin' => 'gpinigin@gmail.com', 'Robbie Hanson' => 'cocoahttpserver@googlegroups.com' }
  s.source = { :git => 'https://github.com/gpinigin/CocoaHTTPServer.git', :tag => s.version.to_s }
  s.source_files = '{Core,Extensions}/**/*.{h,m}'
  s.requires_arc = true

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'

  s.ios.frameworks = 'CFNetwork', 'Security'
  s.osx.frameworks = 'CoreServices', 'Security'

  s.library = 'xml2'
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '"$(SDKROOT)/usr/include/libxml2"' }

  s.dependency "CocoaAsyncSocket"
  s.dependency "CocoaLumberjack"
end
