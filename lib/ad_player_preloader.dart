///
/// Defines how the pre-loader image is scaled inside the player placement.
///
enum AdPlayerScaleType {
  /// Stretches the image to fill the placement (aspect ratio is not kept).
  fill,

  /// Scales the image to cover the whole placement, cropping if needed (default).
  cover,

  /// Scales the image to fit inside the placement, keeping the whole image visible.
  contain,
}

///
/// Pre-loader shown in the player placement until the player starts playing.
///
/// Supported on iOS (AdPlayerLite 1.15.0+) and Android (ad-player-lite 4.8.0+).
///
class AdPlayerPreLoader {
  ///
  /// URL of the image to download and show.
  ///
  final String imageUrl;

  ///
  /// How the image is scaled inside the placement.
  ///
  final AdPlayerScaleType scaleType;

  ///
  /// URL opened in the browser when the pre-loader is tapped.
  /// When `null`, the pre-loader is not clickable.
  ///
  final String? clickThroughUrl;

  const AdPlayerPreLoader.imageUrl(
    this.imageUrl, {
    this.scaleType = AdPlayerScaleType.cover,
    this.clickThroughUrl,
  });

  Map<String, dynamic> toNative() {
    return {
      "type": "imageUrl",
      "imageUrl": imageUrl,
      "scaleType": scaleType.name,
      "clickThroughUrl": clickThroughUrl,
    };
  }
}
