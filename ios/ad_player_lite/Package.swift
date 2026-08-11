// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ad_player_lite",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "ad-player-lite", targets: ["ad_player_lite"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/Aniview/ad-player-lite-ios-spm.git", from: "1.11.0"),
    ],
    targets: [
        .target(
            name: "ad_player_lite",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "AdPlayerLite", package: "ad-player-lite-ios-spm"),
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ]
        )
    ]
)
