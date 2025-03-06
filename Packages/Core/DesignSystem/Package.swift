// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        ),
    ],
    dependencies: [
        .package(path: "../../Core/Models"),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                "Models"
            ],
            path: "Sources"
        ),
    ]
)
