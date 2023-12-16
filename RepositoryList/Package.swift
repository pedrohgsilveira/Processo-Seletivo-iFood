// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RepositoryList",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "RepositoryListPub", targets: ["RepositoryListPub"]),
        .library(name: "RepositoryListImp", targets: ["RepositoryListImp"])
    ],
    dependencies: [
        .package(path: "../CoreCoordinator"),
        .package(path: "../CoreNetwork"),
        .package(path: "../DependencyInjection"),
        .package(path: "../Redux"),
        .package(path: "../UIFoundation"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        .target(
            name: "RepositoryListPub",
            dependencies: [
                .product(name: "CoreCoordinatorPub", package: "CoreCoordinator"),
                .product(name: "CoreNetworkPub", package: "CoreNetwork")
            ]
        ),
        .target(
            name: "RepositoryListImp",
            dependencies: [
                .product(name: "CoreCoordinatorPub", package: "CoreCoordinator"),
                .product(name: "CoreNetworkPub", package: "CoreNetwork"),
                .product(name: "DependencyInjection", package: "DependencyInjection"),
                .product(name: "Redux", package: "Redux"),
                .product(name: "UIFoundation", package: "UIFoundation"),
                "RepositoryListPub",
                "SnapKit"
            ]
        )
    ]
)
