import 'package:flutter/foundation.dart';

enum AdPlayerState {
  preparing,
  ready,
  playingContent,
  playingAdVideo,
  notPlaying,
  display;

  @internal
  factory AdPlayerState.fromNative(dynamic value) {
    return switch (value) {
      "Preparing" => preparing,
      "Ready" => ready,
      "PlayingContent" => playingContent,
      "PlayingAdVideo" => playingAdVideo,
      "NotPlaying" => notPlaying,
      "Display" => display,
      _ => throw Exception("unknown state value: $value"),
    };
  }
}
