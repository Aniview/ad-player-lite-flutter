import 'package:ad_player_lite/ad_player_controller.dart';

///
/// Called when the player is initialized.
///
final class Inventory extends AdPlayerEvent {
  @override
  String toString() => "Inventory";
}

///
/// Indicates the first time an ad sources triggered the AdLoaded event.
///
final class AdSourceLoaded extends AdPlayerEvent {
  @override
  String toString() => "AdSourceLoaded";
}

///
/// Indicates the first time an ad sources triggered the AdLoaded event.
///
final class AdImpression extends AdPlayerEvent {
  final String data;

  AdImpression(this.data);

  @override
  String toString() => "AdImpression(${data.length} bytes)";
}

///
/// Called on a viewable impression.
///
final class AdViewableImpression extends AdPlayerEvent {
  @override
  String toString() => "AdViewableImpression";
}

///
/// Called when the ad reached 25% of the ad video.
///
final class AdVideoFirstQuartile extends AdPlayerEvent {
  @override
  String toString() => "AdVideoFirstQuartile";
}

///
/// Called when the ad reached 50% of the ad video.
///
final class AdVideoMidpoint extends AdPlayerEvent {
  @override
  String toString() => "AdVideoMidpoint";
}

///
/// Called when the ad reached 75% of the ad video.
///
final class AdVideoThirdQuartile extends AdPlayerEvent {
  @override
  String toString() => "AdVideoThirdQuartile";
}

///
/// Called when the ad is completed.
///
final class AdVideoComplete extends AdPlayerEvent {
  @override
  String toString() => "AdVideoComplete";
}

///
/// Called when the ad is clicked on.
///
final class AdClickThrough extends AdPlayerEvent {
  @override
  String toString() => "AdClickThrough";
}

///
/// Called when an ad is skipped.
///
final class AdSkipped extends AdPlayerEvent {
  @override
  String toString() => "AdSkipped";
}

///
/// Called when the ad skip button becomes available.
///
final class AdCanSkipStateChange extends AdPlayerEvent {
  @override
  String toString() => "AdCanSkipStateChange";
}

///
/// Called when the ad is paused.
///
final class AdPaused extends AdPlayerEvent {
  @override
  String toString() => "AdPaused";
}

///
/// Called when the ad starts playing or resumed.
///
final class AdPlaying extends AdPlayerEvent {
  @override
  String toString() => "AdPlaying";
}

///
/// Called on a viewable impression.
///
final class AdWaterfallEnd extends AdPlayerEvent {
  @override
  String toString() => "AdWaterfallEnd";
}

///
/// Called when the ad volume is changed. Contains the new volume level in the [AdVolumeChange.volume] parameter.
///
final class AdVolumeChange extends AdPlayerEvent {
  final double volume;

  AdVolumeChange({required this.volume});

  @override
  String toString() => "AdVolumeChange($volume)";
}

///
/// Called when the ad duration is changed.
///
final class AdDurationChange extends AdPlayerEvent {
  final Duration duration;

  AdDurationChange({required this.duration});

  @override
  String toString() => "AdDurationChange($duration)";
}

///
/// Called when ad view time changes.
///
final class AdVideoTimeChanged extends AdPlayerEvent with MarkerNotLogFriendly {
  final Duration position;
  final Duration duration;

  AdVideoTimeChanged({
    required this.position,
    required this.duration,
  });

  @override
  String toString() => "AdVideoTimeChanged($position/$duration)";
}

///
/// Called by the player every time it finish running 1 + vastRetry waterfall runs without impression.
/// An (optional) error message can be found at [AdError.message].
///
final class AdError extends AdPlayerEvent {
  final String message;

  AdError(this.message);

  @override
  String toString() => "AdError($message)";
}

///
/// Called also whenever the player decides that it should stop running, for example when maxImp
/// or maxRun is reached, to indicate the player is stopping calls for ads.
///
final class AdErrorLimit extends AdPlayerEvent {
  @override
  String toString() => "AdErrorLimit";
}

///
/// Called when the content video is paused.
///
final class ContentPaused extends AdPlayerEvent {
  @override
  String toString() => "ContentPaused";
}

///
/// Called when the content video resume playing.
///
final class ContentPlaying extends AdPlayerEvent {
  @override
  String toString() => "ContentPlaying";
}

///
/// Content started playing.
///
final class ContentVideoStart extends AdPlayerEvent {
  @override
  String toString() => "ContentVideoStart";
}

///
/// Called when the content reached 25%.
///
final class ContentVideoFirstQuartile extends AdPlayerEvent {
  @override
  String toString() => "ContentVideoFirstQuartile";
}

///
/// Called when the content reached 50%.
///
final class ContentVideoMidpoint extends AdPlayerEvent {
  @override
  String toString() => "ContentVideoMidpoint";
}

///
/// Called when the content reached 75%.
///
final class ContentVideoThirdQuartile extends AdPlayerEvent {
  @override
  String toString() => "ContentVideoThirdQuartile";
}

///
/// Called when the content is completed.
///
final class ContentVideoComplete extends AdPlayerEvent {
  @override
  String toString() => "ContentVideoComplete";
}

///
/// Called when content (except buttons) is clicked.
///
final class ContentClicked extends AdPlayerEvent {
  @override
  String toString() => "ContentClicked";
}

///
/// Called when the content volume is changed. Contains the new volume level in the [ContentVolumeChange.volume] parameter.
///
final class ContentVolumeChange extends AdPlayerEvent {
  final double volume;

  ContentVolumeChange({required this.volume});

  @override
  String toString() => "ContentVolumeChange($volume)";
}

///
/// Called when the content is completed.
///
final class ContentVideoTimeChanged extends AdPlayerEvent
    with MarkerNotLogFriendly {
  final Duration position;
  final Duration duration;

  ContentVideoTimeChanged({
    required this.position,
    required this.duration,
  });

  @override
  String toString() => "ContentVideoTimeChanged($position/$duration)";
}

///
/// Called by the player when content error occurs
///
final class ContentError extends AdPlayerEvent {
  final String message;

  ContentError(this.message);

  @override
  String toString() => "ContentError($message)";
}

///
/// Called when close button is clicked.
///
final class Close extends AdPlayerEvent {
  @override
  String toString() => "Close";
}

///
/// Called when controller is released.
///
final class Released extends AdPlayerEvent {
  @override
  String toString() => "Released";
}

///
/// Unknown event.
///
final class Unknown extends AdPlayerEvent {
  final Map<dynamic, dynamic> data;

  Unknown(this.data);

  @override
  String toString() => "Unknown($data)";
}

///
/// Marks events that can occur frequently and are better not to be logged
///
mixin MarkerNotLogFriendly {}

///
/// A class that represents an event from the [AdPlayerController].
///
sealed class AdPlayerEvent {
  static AdPlayerEvent fromNative(dynamic value) {
    final map = value as Map<dynamic, dynamic>;
    return switch (map["name"]) {
      "Inventory" => Inventory(),
      "AdSourceLoaded" => AdSourceLoaded(),
      "AdImpression" => AdImpression(map["data"] as String),
      "AdViewableImpression" => AdViewableImpression(),
      "AdVideoFirstQuartile" => AdVideoFirstQuartile(),
      "AdVideoMidpoint" => AdVideoMidpoint(),
      "AdVideoThirdQuartile" => AdVideoThirdQuartile(),
      "AdVideoComplete" => AdVideoComplete(),
      "AdClickThrough" => AdClickThrough(),
      "AdSkipped" => AdSkipped(),
      "AdCanSkipStateChange" => AdCanSkipStateChange(),
      "AdPaused" => AdPaused(),
      "AdPlaying" => AdPlaying(),
      "AdWaterfallEnd" => AdWaterfallEnd(),
      "AdVolumeChange" => AdVolumeChange(
          volume: map["volume"] as double,
        ),
      "AdDurationChange" => AdDurationChange(
          duration: Duration(milliseconds: map["duration"] as int),
        ),
      "AdVideoTimeChanged" => AdVideoTimeChanged(
          position: Duration(milliseconds: map["position"] as int),
          duration: Duration(milliseconds: map["duration"] as int),
        ),
      "AdError" => AdError(map["message"] as String),
      "AdErrorLimit" => AdErrorLimit(),
      "ContentPaused" => ContentPaused(),
      "ContentPlaying" => ContentPlaying(),
      "ContentVideoStart" => ContentVideoStart(),
      "ContentVideoFirstQuartile" => ContentVideoFirstQuartile(),
      "ContentVideoMidpoint" => ContentVideoMidpoint(),
      "ContentVideoThirdQuartile" => ContentVideoThirdQuartile(),
      "ContentVideoComplete" => ContentVideoComplete(),
      "ContentClicked" => ContentClicked(),
      "ContentVolumeChange" => ContentVolumeChange(
          volume: map["volume"] as double,
        ),
      "ContentVideoTimeChanged" => ContentVideoTimeChanged(
          position: Duration(milliseconds: map["position"] as int),
          duration: Duration(milliseconds: map["duration"] as int),
        ),
      "ContentError" => ContentError(map["message"] as String),
      "Close" => Close(),
      "Released" => Released(),
      _ => Unknown(map),
    };
  }
}
