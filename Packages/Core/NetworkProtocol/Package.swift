// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "NetworkProtocol",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "NetworkProtocol",
            targets: ["NetworkProtocol"]
        ),
    ],
    targets: [
        .target(
            name: "NetworkProtocol",
            path: "Sources"
        ),
    ]
)
