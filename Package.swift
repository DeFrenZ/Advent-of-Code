// swift-tools-version:6.2

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [
		.macOS(.v15),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "0.0.1"),
		.package(url: "https://github.com/apple/swift-se0288-is-power", from: "2.0.0"),
        .package(url: "https://github.com/davecom/SwiftGraph", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "AdventOfCode",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Algorithms", package: "swift-algorithms"),
				.product(name: "SE0288_IsPower", package: "swift-se0288-is-power"),
                .product(name: "SwiftGraph", package: "SwiftGraph"),
            ]),
        .testTarget(
            name: "AdventOfCodeTests",
            dependencies: ["AdventOfCode"],
            resources: [
                .process("Input"),
            ]),
    ])
