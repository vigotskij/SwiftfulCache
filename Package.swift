// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SwiftfulCache",
    platforms: [
        .iOS(.v18)
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
