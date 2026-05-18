# AdPlayer Lite — Flutter Plugin

Flutter plugin for the [Aniview AdPlayer Lite](https://github.com/aniview) SDK. Renders in-read video ad placements on **Android** and **iOS**.


### Requirements

| Platform | Minimum version |
|----------|----------------|
| Android  | API 24 (Android 7.0) |
| iOS      | 15.0 |
| Flutter  | 3.3.0 |
| Dart     | 3.3.0 |


# Usage

Here are steps to use this library on a fresh project:

1. Add 'AdPlayerLite' to your `pubspec.yaml`:
    ```yaml
    dependencies:
      ad_player_lite:
        git:
          url: https://github.com/aniview/ad-player-lite-flutter.git
    ```

2. Initialize `AdPlayerLite` SDK:
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
