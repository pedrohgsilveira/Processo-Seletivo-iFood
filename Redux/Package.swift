// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Redux",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Redux", targets: ["Redux"])
    ],
    dependencies: [],
    targets: [
        .target(name: "Redux", dependencies: [])
    ]
)
