// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "RouterIdentifier",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "RouterIdentifier",
            targets: ["RouterIdentifier"]
        ),
    ],
    targets: [
        .target(
            name: "RouterIdentifier",
            path: "Sources"
        ),
    ]
)
