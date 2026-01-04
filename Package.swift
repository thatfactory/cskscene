// swift-tools-version:6.2

import PackageDescription

let package = Package(
    name: "CSKScene",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .tvOS(.v18),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "CSKScene",
            targets: ["CSKScene"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/thatfactory/applogger",
            from: "0.1.0"
        ),
        .package(
            url: "https://github.com/thatfactory/gcoverseer",
            from: "0.1.0"
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
