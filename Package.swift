// swift-tools-version:6.4

import PackageDescription

let package = Package(
    name: "CSKScene",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26)
    ],
    products: [
        .library(
            name: "CSKScene",
            targets: ["CSKScene"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/thatfactory/applogger",
            from: "1.0.0"
        ),
        .package(
            url: "https://github.com/thatfactory/gcoverseer",
            from: "0.1.2"
        )
    ],
    targets: [
        .target(
            name: "CSKScene",
            dependencies: [
                .product(
                    name: "AppLogger",
                    package: "applogger"
                ),
                .product(
                    name: "GCOverseer",
                    package: "gcoverseer"
                )
            ]
        ),
        .testTarget(
            name: "CSKSceneTests",
            dependencies: ["CSKScene"]
        )
    ]
)
