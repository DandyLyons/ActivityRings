// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ActivityRings",
    platforms: [
        .iOS(.v15), .macCatalyst(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8), .visionOS(.v1),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ActivityRings",
            targets: ["ActivityRings"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-identified-collections.git", from: "1.1.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ActivityRings",
            dependencies: [
                .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
            ]
        ),
        .testTarget(
            name: "ActivityRingsTests",
            dependencies: ["ActivityRings"]
        ),
    ]
)
