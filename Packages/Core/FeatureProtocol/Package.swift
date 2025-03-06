// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "FeatureProtocol",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "FeatureProtocol",
            targets: ["FeatureProtocol"]
        ),
    ],
    dependencies: [
        .package(
            path: "../RouterProtocol"
        ),
    ],
    targets: [
        .target(
            name: "FeatureProtocol",
            dependencies: [
                "RouterProtocol"
            ],
            path: "Sources"
        ),
    ]
)
