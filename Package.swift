// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ProgressX",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "ProgressX", targets: ["ProgressX"])
    ],
    targets: [
        .target(name: "ProgressX",
                path: ".",
                sources: ["Sources"]),
    ],
    swiftLanguageVersions: [.v5]
)
