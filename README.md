# AdPlayer Lite — Flutter Plugin

Flutter plugin for the [Aniview AdPlayer Lite](https://github.com/aniview) SDK. Renders in-read
video ad placements on **Android** and **iOS**.

### Requirements

| Platform | Minimum version      |
|----------|----------------------|
| Android  | API 24 (Android 7.0) |
| iOS      | 15.0                 |
| Flutter  | 3.24.0               |
| Dart     | 3.3.0                |

> **Note:** Flutter 3.24.0+ is required for iOS builds (the plugin uses Swift Package Manager).

## Installation

Add the plugin to your `pubspec.yaml`:

```yaml
dependencies:
  ad_player_lite:
    git:
      url: https://github.com/aniview/ad-player-lite-flutter.git
```

Then run:

```bash
flutter pub get
```

On iOS, Flutter will automatically resolve the native SDK via Swift Package Manager.
On Android, make sure the desugaring library is configured (see [Android config](#android-config) below).

# Usage

1. Initialize `AdPlayerLite` SDK:
    ```dart
    final player = AdPlayer.initialize(
      iosStoreUrl: "STORE_URL_TO_YOUR_APP",
    );
    ```
   \* on iOS, pass your App Store URL — it is used by the SDK for attribution.

3. Create a tag:
    ```dart
    final tag = await player.getTag(pubId: pubId, tagId: tagId);
    ```
   \* `pubId` and `tagId` are obtained from the contact person.

4. Create a new controller from the tag:
    ```dart
    final controller = await tag.newInReadController(); 
    ```

5. Add a widget to the tree:
    ```dart
    Widget build(Context context) {
      return Column(
        children: [
          AdPlayerView(controller: controller),
        ],
      );
    }
    ```

6. Dispose the controller when the screen is closed:
    ```dart
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }
    ```
   \* see [Releasing the controller](#releasing-the-controller) below.

## Android config

Android build also requires additional configuration.

In your application's build.gradle.kts (`/android/app/build.gradle.kts`) add following:

```kts
android {
    compileOptions {
        isCoreLibraryDesugaringEnabled = true
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
```

# Observing Events and States

AdPlayerLite library provides different events and states to track ads:

```dart

final stateSubscription = controller.state.listen((state) {
  print("{state} has changed");
});

final eventsSubscription = controller.events.listen((event) {
  print("{event} was triggered");
});
```

# Displaying Interstitial Ads

To show interstitial ads use following api:

```dart

final controller = await tag.newInterstitialController(
  config: AdPlayerInterstitialConfig(
    onDismissListener: (e) => e.dispose(),
  ),
);
controller.launchInterstitial();
```

# Releasing the controller

Every controller created by `newInReadController()` or `newInterstitialController()` holds a native player.
Call `dispose()` when it is no longer needed — e.g. in `State.dispose()`, or in `onDismissListener` for interstitials.

```dart
controller.dispose();
```

`dispose()` stops playback, releases the native player together with its ad tracking, and stops the `state`/`events` streams.
The controller must not be used after `dispose()`.

Under the hood it calls `release()` on Android and `destroy()` on iOS.
