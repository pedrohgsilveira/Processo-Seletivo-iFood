// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MainApp",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "MainApp", targets: ["MainApp"])
    ],
    dependencies: [
        .package(path: "../CoreCoordinator"),
        .package(path: "../CoreNetwork"),
        .package(path: "../DependencyInjection"),
        .package(path: "../RepositoryList"),

    ],
    targets: [
        .target(name: "MainApp", dependencies: [
            .product(name: "CoreCoordinatorImp", package: "CoreCoordinator"),
            .product(name: "CoreCoordinatorPub", package: "CoreCoordinator"),
            .product(name: "CoreNetworkImp", package: "CoreNetwork"),
            .product(name: "CoreNetworkPub", package: "CoreNetwork"),
            .product(name: "DependencyInjection", package: "DependencyInjection"),
            .product(name: "RepositoryListImp", package: "RepositoryList"),
            .product(name: "RepositoryListPub", package: "RepositoryList")
        ]),
        .testTarget(name: "MainAppTests", dependencies: ["MainApp"])
    ]
)
