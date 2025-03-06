// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Home",
            targets: ["Home"]
        ),
    ],
    dependencies: [
        .package(path: "../../Core/FeatureProtocol"),
        .package(path: "../../Core/RouterIdentifier"),
        .package(path: "../../Core/RouterProtocol"),
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Core/Models"),
        .package(path: "../../Core/NetworkProtocol"),
        .package(path: "../../Core/StorageProtocol")
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                "FeatureProtocol",
                "RouterIdentifier",
                "RouterProtocol",
                "DesignSystem",
                "Models",
                "NetworkProtocol",
                "StorageProtocol"
            ],
            path: "Sources"
        ),
    ]
)
