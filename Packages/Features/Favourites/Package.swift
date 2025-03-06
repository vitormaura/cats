// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Favourites",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Favourites",
            targets: ["Favourites"]
        ),
    ],
    dependencies: [
        .package(path: "../../Core/FeatureProtocol"),
        .package(path: "../../Core/RouterIdentifier"),
        .package(path: "../../Core/RouterProtocol"),
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Core/Models"),
        .package(path: "../../Core/StorageProtocol")
    ],
    targets: [
        .target(
            name: "Favourites",
            dependencies: [
                "FeatureProtocol",
                "RouterIdentifier",
                "RouterProtocol",
                "DesignSystem",
                "Models",
                "StorageProtocol"
            ],
            path: "Sources"
        ),
    ]
)
