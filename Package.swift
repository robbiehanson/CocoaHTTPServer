// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "CocoaHTTPServer",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "CocoaHTTPServer",
            targets: ["CocoaHTTPServer"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/robbiehanson/CocoaAsyncSocket.git", from: "7.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CocoaHTTPServer",
            dependencies: ["CocoaAsyncSocket"]),
        .testTarget(
            name: "CocoaHTTPServerTests",
            dependencies: ["CocoaHTTPServer"]),
    ]
)
