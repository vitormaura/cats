// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "StorageProtocol",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "StorageProtocol",
            targets: ["StorageProtocol"]
        ),
    ],
    targets: [
        .target(
            name: "StorageProtocol",
            path: "Sources"
        ),
    ]
)
