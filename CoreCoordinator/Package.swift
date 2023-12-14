// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreCoordinator",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "CoreCoordinatorPub", targets: ["CoreCoordinatorPub"]),
        .library(name: "CoreCoordinatorImp", targets: ["CoreCoordinatorImp"])
    ],
    dependencies: [],
    targets: [
        .target(name: "CoreCoordinatorPub"),
        .target(name: "CoreCoordinatorImp", dependencies: ["CoreCoordinatorPub"]),
        .testTarget(name: "CoreCoordinatorImpTests", dependencies: ["CoreCoordinatorImp"]),
    ]
)
