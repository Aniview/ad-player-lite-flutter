package com.adservrs.adplayer.lite.flutter.mappers

import com.adservrs.adplayer.lite.AdPlayerEvent

internal fun AdPlayerEvent.toFlutterValue() = when (this) {
    is AdPlayerEvent.Inventory -> mapOf(
        "name" to "Inventory",
    )

    is AdPlayerEvent.AdSourceLoaded -> mapOf(
        "name" to "AdSourceLoaded",
    )

    is AdPlayerEvent.AdImpression -> mapOf(
        "name" to "AdImpression",
        "data" to this.data,
    )

    is AdPlayerEvent.AdViewableImpression -> mapOf(
        "name" to "AdViewableImpression",
    )

    is AdPlayerEvent.AdVideoFirstQuartile -> mapOf(
        "name" to "AdVideoFirstQuartile",
    )

    is AdPlayerEvent.AdVideoMidpoint -> mapOf(
        "name" to "AdVideoMidpoint",
    )

    is AdPlayerEvent.AdVideoThirdQuartile -> mapOf(
        "name" to "AdVideoThirdQuartile",
    )

    is AdPlayerEvent.AdVideoComplete -> mapOf(
        "name" to "AdVideoComplete",
    )

    is AdPlayerEvent.AdClickThrough -> mapOf(
        "name" to "AdClickThrough",
    )

    is AdPlayerEvent.AdSkipped -> mapOf(
        "name" to "AdSkipped",
    )

    is AdPlayerEvent.AdCanSkipStateChange -> mapOf(
        "name" to "AdCanSkipStateChange",
    )

    is AdPlayerEvent.AdPaused -> mapOf(
        "name" to "AdPaused",
    )

    is AdPlayerEvent.AdPlaying -> mapOf(
        "name" to "AdPlaying",
    )

    is AdPlayerEvent.AdWaterfallEnd -> mapOf(
        "name" to "AdWaterfallEnd",
    )

    is AdPlayerEvent.AdVolumeChange -> mapOf(
        "name" to "AdVolumeChange",
        "volume" to this.volume,
    )

    is AdPlayerEvent.AdDurationChange -> mapOf(
        "name" to "AdDurationChange",
        "duration" to this.duration.inWholeMilliseconds,
    )

    is AdPlayerEvent.AdVideoTimeChanged -> mapOf(
        "name" to "AdVideoTimeChanged",
        "position" to this.position.inWholeMilliseconds,
        "duration" to this.duration.inWholeMilliseconds,
    )

    is AdPlayerEvent.AdError -> mapOf(
        "name" to "AdError",
        "message" to this.message,
    )

    is AdPlayerEvent.AdErrorLimit -> mapOf(
        "name" to "AdErrorLimit",
    )

    is AdPlayerEvent.ContentPaused -> mapOf(
        "name" to "ContentPaused",
    )

    is AdPlayerEvent.ContentPlaying -> mapOf(
        "name" to "ContentPlaying",
    )

    is AdPlayerEvent.ContentVideoStart -> mapOf(
        "name" to "ContentVideoStart",
    )

    is AdPlayerEvent.ContentVideoFirstQuartile -> mapOf(
        "name" to "ContentVideoFirstQuartile",
    )

    is AdPlayerEvent.ContentVideoMidpoint -> mapOf(
        "name" to "ContentVideoMidpoint",
    )

    is AdPlayerEvent.ContentVideoThirdQuartile -> mapOf(
        "name" to "ContentVideoThirdQuartile",
    )

    is AdPlayerEvent.ContentVideoComplete -> mapOf(
        "name" to "ContentVideoComplete",
    )

    is AdPlayerEvent.ContentClicked -> mapOf(
        "name" to "ContentClicked",
    )

    is AdPlayerEvent.ContentVolumeChange -> mapOf(
        "volume" to this.volume,
        "name" to "ContentVolumeChange",
    )

    is AdPlayerEvent.ContentVideoTimeChanged -> mapOf(
        "name" to "ContentVideoTimeChanged",
        "position" to this.position.inWholeMilliseconds,
        "duration" to this.duration.inWholeMilliseconds,
    )

    is AdPlayerEvent.ContentError -> mapOf(
        "name" to "ContentError",
        "message" to this.message,
    )

    is AdPlayerEvent.Close -> mapOf(
        "name" to "Close",
    )

    is AdPlayerEvent.Released -> mapOf(
        "name" to "Released",
    )
}
