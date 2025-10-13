// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TappAdjust",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TappAdjust",
            targets: ["TappAdjust"]),
    ],
    dependencies: [
        .package(url: "https://github.com/adjust/ios_sdk.git", exact: "5.0.1"),
        .package(url: "https://github.com/tapp-so/Tapp-Networking-iOS.git", exact: "1.0.86"),
        .package(url: "https://github.com/tapp-so/Tapp-iOS.git", exact: "1.0.87"),
    ],

    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TappAdjust",
            dependencies: [
                .product(name: "AdjustSdk", package: "ios_sdk"),
                .product(name: "TappNetworking", package: "Tapp-Networking-iOS"),
                .product(name: "Tapp", package: "Tapp-iOS")
            ]),
        .testTarget(
            name: "TappAdjustTests",
            dependencies: ["TappAdjust"]
        ),
    ]
)
