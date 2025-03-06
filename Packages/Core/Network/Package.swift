// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Network",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Network",
            targets: ["Network"]
        ),
    ],
    dependencies: [
        .package(
            path: "../NetworkProtocol"
        ),
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: [
                "NetworkProtocol"
            ],
            path: "Sources"
        ),
    ]
)
