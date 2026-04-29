package com.adservrs.adplayer.lite.flutter.mappers

import com.adservrs.adplayer.lite.AdPlayerState

internal fun AdPlayerState.toFlutterValue() = when (this) {
    AdPlayerState.Preparing -> "Preparing"
    AdPlayerState.Ready -> "Ready"
    AdPlayerState.Playing.Content -> "PlayingContent"
    AdPlayerState.Playing.AdVideo -> "PlayingAdVideo"
    AdPlayerState.NotPlaying -> "NotPlaying"
    AdPlayerState.Display -> "Display"
}
