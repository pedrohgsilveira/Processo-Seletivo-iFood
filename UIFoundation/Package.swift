// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIFoundation",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "UIFoundation", targets: ["UIFoundation"])
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        .target(name: "UIFoundation", dependencies: ["SnapKit"])
    ]
)
