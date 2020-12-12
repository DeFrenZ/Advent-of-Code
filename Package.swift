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
        .package(url: "https://github.com/apple/swift-standard-library-preview.git", from: "0.0.1"),
        .package(url: "https://github.com/davecom/SwiftGraph", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "AdventOfCode",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "StandardLibraryPreview", package: "swift-standard-library-preview"),
                .product(name: "SwiftGraph", package: "SwiftGraph"),
            ]),
        .testTarget(
            name: "AdventOfCodeTests",
            dependencies: ["AdventOfCode"],
            resources: [
                .process("Input"),
            ]),
    ])
