// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "TabBar",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "TabBar",
            targets: ["TabBar"]
        ),
    ],
    dependencies: [
        .package(path: "../../Core/FeatureProtocol"),
        .package(path: "../../Core/RouterIdentifier"),
        .package(path: "../../Core/RouterProtocol"),
        .package(path: "../../Core/RouterBuilder"),
        .package(path: "../../Core/DesignSystem")
    ],
    targets: [
        .target(
            name: "TabBar",
            dependencies: [
                "FeatureProtocol",
                "RouterIdentifier",
                "RouterProtocol",
                "RouterBuilder",
                "DesignSystem"
            ],
            path: "Sources"
        ),
    ]
)
