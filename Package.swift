// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "ProgressX",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "ProgressX", targets: ["ProgressX"])
    ],
    targets: [
        .target(name: "ProgressX"),
        .testTarget(name: "ProgressXTests",
                    dependencies: ["ProgressX"])
    ],
    swiftLanguageVersions: [.v5]
)
