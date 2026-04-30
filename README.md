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

Initialize SDK by calling 
```dart
final adPlayer = AdPlayer.initialize(iosStoreUrl: "https://apps.apple.com/us/app/demo-app/id1234567");

```
On iOS, pass your App Store URL — it is used by the SDK for attribution. On Android the call is a no-op and the parameter is ignored.


### 2. Initialize AdPlayer 

```dart

Widget buildContent(BuildContext context) {
    final snapshot = useFuture(
      useMemoized(() {
        return adPlayer.getTag(pubId: pubId, tagId: tagId).then((e) => e.newInReadController());
      }),
    );
)
```

`pubId` and `tagId` are obtained from the contact person.

---

## API Reference

## AdPlayer

### Initializes instance of the AdPlayer.

```dart

  static AdPlayer initialize({String? iosStoreUrl}) {
    if (!initialized) {
      _channel.invokeMethod("initialize", {
        "iosStoreUrl": iosStoreUrl,
      });
      initialized = true;
    }
    return const AdPlayer._();
  }

```

### Returns tag for specific configuration.

```dart

Future<AdPlayerTag> getTag({
    required String pubId,
    required String tagId,
  }) async {
    final id = await _channel.invokeMethod("getTag", {
      "pubId": pubId,
      "tagId": tagId,
    });
    return AdPlayerTag(id as String);
  }

```

## AdPlayerView

'AdPlayerView' - player container view should be initialized with 'controller' parameter:

```dart

Widget buildContent(BuildContext context) {
    final snapshot = useFuture(
      useMemoized(() {
        return adPlayer.getTag(pubId: pubId, tagId: tagId).then((e) => e.newInReadController());
      }),
    );

    final controller = snapshot.data;
```

```dart

    return Column(
      children: [
        Expanded(child: AdPlayerView(controller: controller)),
        buildControls(context, controller),
        Expanded(child: buildPanel(context, controller)),
      ],
    );

```

## Returns current version of plagin.

```dart

static Future<String> getVersion() async {
    return await _channel.invokeMethod<String>("getVersion") ?? "unknown";
  }

```
## AdPlayerTag

### Returns new controller for in-read ads.

```dart

Future<AdPlayerInReadController> newInReadController() async {
    final controllerId = await _channel.invokeMethod("newInReadController", {"id": id});
    return AdPlayerInReadController(controllerId as String);
  }
```

## AdPlayerController

### State changes stream

```dart

late final state = _stateChannel.receiveBroadcastStream({'id': id}).map(AdPlayerState.fromNative);

```

### Events stream

```dart

late final state = _stateChannel.receiveBroadcastStream({'id': id}).map(AdPlayerState.fromNative);

```

## Release all resources used by this controller.

```dart

void dispose() {
    _methodChannel.invokeMethod("dispose", {"id": id});
  }

```
## Current player state.

```dart

Future<AdPlayerState> getCurrentState() async {
    final result = await _methodChannel.invokeMethod("getCurrentState", {"id": id});
    return AdPlayerState.fromNative(result);
  }

```

## Pauses the player if it's playing.

```dart

void pause() {
    _methodChannel.invokeMethod("pause", {"id": id});
  }

```

## Resumes the player if it's paused.

```dart

void resume() {
    _methodChannel.invokeMethod("resume", {"id": id});
  }

```

## Skips the currently playing ad if there is one.

```dart

void skipAd() {
    _methodChannel.invokeMethod("skipAd", {"id": id});
  }

```

##  Moves the player to or from the fullscreen display mode.

```dart

void toggleFullscreen() {
    _methodChannel.invokeMethod("toggleFullscreen", {"id": id});
  }

```



The widget renders the native SDK view and fills 100% of the space provided by its parent. It does not impose any size of its own.

---