# AdPlayer Lite — Flutter Plugin

Flutter plugin for the [Aniview AdPlayer Lite](https://github.com/aniview) SDK. Renders in-read video ad placements on **Android** and **iOS**.

---

## Requirements

| Platform | Minimum version |
|----------|----------------|
| Android  | API 24 (Android 7.0) |
| iOS      | 15.0 |
| Flutter  | 3.3.0 |
| Dart     | 3.3.0 |

---

## Installation

Add 'AdPlayerLite' to your `pubspec.yaml`:

```yaml
dependencies:
  ad_player_lite:
    git:
      url: https://github.com/aniview/ad-player-lite-flutter.git
```

## Usage

### 1. Initialize `AdPlayerLite` SDK:

```dart

final adPlayer = AdPlayer.initialize(iosStoreUrl: "STORE_URL_TO_YOUR_APP");

```
* on iOS, pass your App Store URL — it is used by the SDK for attribution.

--- 

### 2. Create tag:

```dart

final tag = await adPlayer.getTag(pubId: pubId, tagId: tagId);
     
```

`pubId` and `tagId` are obtained from the contact person.

--- 

### 3. To use `InRead ads` features create `InRead` controller from tag: 


```dart

final controller = await tag.newInReadController();
     
```
---

### 4. To add AdPlayer view to the widget:

```dart

return Column(
  children: [
    AdPlayerView(controller: controller),
  ],
);

```

```dart

return AdPlayerView(controller: controller);

```
---

### 5. To subscribe to events stream: 

```dart

final subscription = controller.events.listen((event) {

});

```
---

### 6. To subscribe to state stream:

```dart

final subscription = controller.state.listen((state) {

});


```
---

### 7. To add `Interstitial ads` features (Interstitial content is presented over current widget):

```dart
    
final config = AdPlayerInterstitialConfig(
    dismissOnBack: true,
    showCloseButtonAfterAdDuration: true,
    noAdTimeout: Duration(seconds: 5),
    stalledVideoTimeout: Duration(seconds: 10),
    onDismissListener: (e) => e.dispose(),
);

final controller = await tag.newInterstitialController(config: config);
controller.launchInterstitial();

```
---
