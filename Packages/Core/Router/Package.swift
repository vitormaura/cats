// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Router",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Router",
            targets: ["Router"]),
    ],
    dependencies: [
        .package(
            path: "../RouterProtocol"
        ),
    ],
    targets: [
        .target(
            name: "Router",
            dependencies: [
                "RouterProtocol"
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "RouterTests",
            dependencies: ["Router"]
        ),
    ]
)
