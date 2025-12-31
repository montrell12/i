// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "EcommerceApp",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "EcommerceApp",
            targets: ["EcommerceApp"]),
    ],
    targets: [
        .target(
            name: "EcommerceApp",
            dependencies: []),
        .testTarget(
            name: "EcommerceAppTests",
            dependencies: ["EcommerceApp"]),
    ]
)
