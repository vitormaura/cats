// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "RouterBuilder",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "RouterBuilder",
            targets: ["RouterBuilder"]),
    ],
    dependencies: [
        .package(
            path: "../FeatureProtocol"
        ),
        .package(
            path: "../RouterProtocol"
        ),
    ],
    targets: [
        .target(
            name: "RouterBuilder",
            dependencies: [
                "FeatureProtocol",
                "RouterProtocol"
            ],
            path: "Sources"
        ),
    ]
)
