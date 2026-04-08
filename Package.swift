// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "SwiftfulCache",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftfulCache",
            targets: ["SwiftfulCache"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftfulCache",
            path: "Sources/SwiftfulCache"
        ),
        .testTarget(
            name: "SwiftfulCacheTests",
            dependencies: ["SwiftfulCache"],
            path: "Tests/SwiftfulCacheTests"
        ),
    ]
)
