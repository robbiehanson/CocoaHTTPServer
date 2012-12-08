INFO:

This is a bare bones project demonstrating how to embed the CocoaHTTPServer in an iOS project.

Notice the Web folder. This folder is added to the project as a resource, and the folder itself is copied into the iPhone app. The contents of the folder are set as the document root of the http server.

INSTRUCTIONS:

Open the Xcode project, and build and go.

On the Xcode console you'll see a message saying:
"Started HTTP server on port 12345"

Now open your browser and type in the URL to access the server.
If you're running it via the simulator, then you can use:
http://localhost: 12345

If you're running it on your device, then you'll need to use:
http://<local IP of device>: 12345

(Replace 12345 with whatever port the server is actually running on.)

 
REQUIRES:

FRAMEWORKS:
- UIKit
- Foundation
- CoreGraphics
- CFNetwork
- Security

+ Background Mode:
- AVFoundation
- CoreFoundation
- AudioToolbox

Info.plist:
- Required background modes
    - App plays audio


Enjoy.