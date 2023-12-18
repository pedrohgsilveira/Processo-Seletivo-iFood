// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependencyInjection",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "DependencyInjection", targets: ["DependencyInjection"])
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.4")
    ],
    targets: [
        .target(name: "DependencyInjection", dependencies: ["Swinject"])
    ]
)
