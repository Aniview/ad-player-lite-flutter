## 0.0.2 (unreleased)

**Breaking change**: `AdPlayerLitePlacementWidget` no longer accepts `pubId`
and `tagId` directly. Create an `AdPlayerLiteController` and pass it instead.

Migration:

```dart
// Before
AdPlayerLitePlacementWidget(pubId: '...', tagId: '...')

// After
final controller = AdPlayerLiteController(pubId: '...', tagId: '...');
// ...
AdPlayerLitePlacementWidget(controller: controller)
// call controller.dispose() when done
```

## 0.0.1

* TODO: Describe initial release.
