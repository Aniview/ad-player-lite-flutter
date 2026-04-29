# AdPlayer Lite — Flutter Plugin

Flutter plugin for the [Aniview AdPlayer Lite](https://github.com/aniview) SDK. Renders in-read video ad placements on **Android** and **iOS**.

---

## Requirements

| Platform | Minimum version |
|----------|----------------|
| Android  | API 24 (Android 7.0) |
| iOS      | 13.0 |
| Flutter  | 3.3.0 |
| Dart     | 3.3.0 |

---

## Installation

Add the plugin to your `pubspec.yaml`:

```yaml
dependencies:
  ad_player_lite:
    git:
      url: https://github.com/aniview/ad-player-lite-flutter.git
```

### Android — add the Aniview Maven repository

In your app's `android/settings.gradle` (or `settings.gradle.kts`), add the Aniview Maven repository to **both** `pluginManagement` and `dependencyResolutionManagement`:

```kotlin
pluginManagement {
    repositories {
        // ... existing entries
        maven("https://us-central1-maven.pkg.dev/mobile-sdk-fd2e4/adservr-maven")
    }
}

dependencyResolutionManagement {
    repositories {
        // ... existing entries
        maven("https://us-central1-maven.pkg.dev/mobile-sdk-fd2e4/adservr-maven")
    }
}
```

### iOS — install pods

```bash
cd ios && pod install
```

The plugin bundles the `AdPlayerLite.xcframework` and pulls in `GoogleAds-IMA-iOS-SDK` via CocoaPods automatically.

---

## Usage

### 1. Initialize the SDK

Call `AdPlayerLite.initialize` once at app startup, before `runApp`. On iOS, pass your App Store URL — it is used by the SDK for attribution. On Android the call is a no-op and the parameter is ignored.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AdPlayerLite.initialize(
    iosStoreUrl: 'https://apps.apple.com/us/app/your-app/id123456789',
  );

  runApp(const MyApp());
}
```

### 2. Display the player

Place `AdPlayerLitePlacementWidget` anywhere in your widget tree. **You control the size** — wrap it in a `SizedBox`, `AspectRatio`, or any other sizing widget.

```dart
import 'package:ad_player_lite/adplayerlite_placement_widget.dart';

// 16:9 aspect ratio (recommended for video ads)
AspectRatio(
  aspectRatio: 16 / 9,
  child: AdPlayerLitePlacementWidget(
    pubId: 'your_publisher_id',
    tagId: 'your_tag_id',
  ),
)

// Fixed size
SizedBox(
  height: 200,
  child: AdPlayerLitePlacementWidget(
    pubId: 'your_publisher_id',
    tagId: 'your_tag_id',
  ),
)
```

`pubId` and `tagId` are obtained from the contact person.

---

## API Reference

### `AdPlayerLite`

```dart
// Initialize the SDK — call once before runApp
static Future<void> initialize({String? storeUrl})

// Get the plugin version string
static Future<String> getVersion()
```

### `AdPlayerLitePlacementWidget`

```dart
AdPlayerLitePlacementWidget({
  required String pubId,           // Publisher ID 
  required String tagId,           // Tag ID
  PlatformViewHitTestBehavior hitTestBehavior,  // default: opaque
})
```

The widget renders the native SDK view and fills 100% of the space provided by its parent. It does not impose any size of its own.

---