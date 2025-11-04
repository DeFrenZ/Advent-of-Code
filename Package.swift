// swift-tools-version:6.2

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [
		.macOS(.v26),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.6.2"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.1"),
		.package(url: "https://github.com/apple/swift-se0288-is-power", from: "2.0.0"),
        .package(url: "https://github.com/davecom/SwiftGraph", from: "3.1.0"),
    ],
    targets: [
        .target(
            name: "AdventOfCode",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
				.product(name: "SE0288_IsPower", package: "swift-se0288-is-power"),
                .product(name: "SwiftGraph", package: "SwiftGraph"),
            ]),
		.executableTarget(
			name: "AdventOfCodeExe",
			dependencies: [
				"AdventOfCode",
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			]),
		.target(
			name: "AdventOfCodeInputs",
			resources: [
				.process("Resources"),
			]),
        .testTarget(
            name: "AdventOfCodeTests",
            dependencies: [
				"AdventOfCode",
				"AdventOfCodeInputs",
			]),
    ])
