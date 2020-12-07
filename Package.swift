// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [
        .macOS(.v10_15),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "0.0.1"),
        .package(url: "https://github.com/davecom/SwiftGraph", from: "3.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AdventOfCode",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "SwiftGraph", package: "SwiftGraph"),
            ]),
        .testTarget(
            name: "AdventOfCodeTests",
            dependencies: ["AdventOfCode"],
            resources: [
                .process("Input"),
            ]),
    ])
