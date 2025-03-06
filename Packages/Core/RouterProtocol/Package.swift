// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "RouterProtocol",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "RouterProtocol",
            targets: ["RouterProtocol"]
        ),
    ],
    dependencies: [
        .package(
            path: "../RouterIdentifier"
        ),
    ],
    targets: [
        .target(
            name: "RouterProtocol",
            dependencies: [
                "RouterIdentifier"
            ],
            path: "Sources"
        ),
    ]
)
