// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreNetwork",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "CoreNetworkPub", targets: ["CoreNetworkPub"]),
        .library(name: "CoreNetworkImp", targets: ["CoreNetworkImp"])
    ],
    dependencies: [],
    targets: [
        .target(name: "CoreNetworkPub"),
        .target(name: "CoreNetworkImp", dependencies: ["CoreNetworkPub"]),
        .testTarget(name: "CoreNetworkImpTests", dependencies: ["CoreNetworkImp"])
    ]
)
