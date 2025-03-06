// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Storage",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Storage",
            targets: ["Storage"]
        ),
    ],
    dependencies: [
        .package(path: "../../Core/StorageProtocol"),
    ],
    targets: [
        .target(
            name: "Storage",
            dependencies: [
                "StorageProtocol"
            ],
            path: "Sources",
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
