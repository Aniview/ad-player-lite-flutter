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
        // TEMP local test: native sources from ad-player-lite-ios
        .package(path: "/Users/zhanna.moskaliuk/Developer/Aniview/ad-player-lite-ios/ad-player-lite-spm-sources"),
        // .package(url: "https://github.com/Aniview/ad-player-lite-ios-spm.git", from: "1.16.0"),
        // .package(url: "https://github.com/Aniview/display-ads-ios-spm.git", from: "1.4.0"),
    ],
    targets: [
        .target(
            name: "ad_player_lite",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "AdPlayerLite", package: "ad-player-lite-spm-sources"),
                // .product(name: "AdPlayerLite", package: "ad-player-lite-ios-spm"),
                // .product(name: "DisplayAdsSDK", package: "display-ads-ios-spm"),
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ]
        )
    ]
)
