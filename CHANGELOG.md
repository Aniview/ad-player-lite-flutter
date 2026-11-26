## 1.5.0
- feature: `AdPlayer.getTag` takes an optional `macros` map (`Map<String, String>`) that is passed to the native SDKs
- feature: `AdPlayer.initialize` takes an optional `domain` (e.g. "domainname.tv") reported as the app domain in ad requests on both platforms; must be set before `getTag`
- iOS: updated `ad-player-lite-ios-spm` to 1.16.0 (required for `domain`)

## 1.4.0
- feature: added pre-loader for in-read controllers: `tag.newInReadController(preLoader: AdPlayerPreLoader.imageUrl(...))` with `AdPlayerScaleType` (fill / cover / contain) and optional click-through URL
- iOS: updated `ad-player-lite-ios-spm` to 1.15.0
- iOS: updated `display-ads-ios-spm` to 1.4.0 (required by the new `DisplayAdsProviding` API in AdPlayerLite 1.15.0)
- Android: updated `com.adservrs:ad-player-lite` to 4.8.0
- **Note (Android):** apps must now use compileSdk 37, an Android Gradle Plugin that supports API 37 (e.g. 9.2.0+) and Kotlin 2.3+.

## 1.3.3
- fix: updated android ad-player-lite dependency to 4.6.2

## 1.3.2
- iOS: updated `ad-player-lite-ios-spm` to 1.14.2
- Android: updated `com.adservrs:ad-player-lite` to 4.6.2

## 1.3.1
- package dependencies upgrade for both platforms
- minimum Flutter version raised to 3.24.0.
- **Note:** iOS plugin is SPM-only

## 1.3.0
- display ads now use Google Mobile Ads SDK 13.x (display-ads-ios-spm 1.1.0). Compatible with `google_mobile_ads` 8.x.
- **Note:** iOS apps must use Google Mobile Ads SDK >= 13.0.0 (Xcode 16+). Apps pinned to GMA 11.x/12.x should stay on 1.2.x.

## 1.2.2
- fix: added support for css styling in ios

## 1.2.1
- fix: `AdPlayerController.dispose()` now releases the native player (no playback or ad tracking after dispose)

## 1.2.0 
- added support for display ads 

## 1.1.0
- added device model macro
- added device manufacturer macro

## 1.0.0

- feature: floating placement support

## 0.3.0

- feature: new reporting macros support
- fix: sdkconfig ref1 issue

## 0.2.0

- added interstitial ads support
- improved documentation

## 0.1.0

- added in-read ads support
- added play ad feature
- added pause ad feature
- added display ad fullscreen feature
- added ad state listener
- added ad events listener
