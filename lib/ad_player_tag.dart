import 'package:ad_player_lite/ad_player_controller.dart';
import 'package:ad_player_lite/ad_player_preloader.dart';
import 'package:flutter/services.dart';

export 'package:ad_player_lite/ad_player_preloader.dart';

///
/// Tag object that is used to crate different controllers.
///
class AdPlayerTag {
  static const _channel =
      MethodChannel("com.adservrs.adplayer.lite/AdPlayerTag");

  final String id;

  AdPlayerTag(this.id);

  ///
  /// Creates a new in-read controller.
  /// [preLoader] is shown in the placement until the player starts playing.
  ///
  Future<AdPlayerInReadController> newInReadController({
    AdPlayerPreLoader? preLoader,
  }) async {
    final controllerId = await _channel.invokeMethod("newInReadController", {
      "id": id,
      "preLoader": preLoader?.toNative(),
    });

    return AdPlayerInReadController(controllerId as String);
  }

  Future<AdPlayerInterstitialController> newInterstitialController({
    AdPlayerInterstitialConfig config = const AdPlayerInterstitialConfig(),
  }) async {
    final controllerId =
        await _channel.invokeMethod("newInterstitialController", {
      "id": id,
      "config": config.toNative(),
    });

    return AdPlayerInterstitialController(controllerId as String, config);
  }
}

class AdPlayerInterstitialConfig {
  ///
  /// Allow interstitial view being dismissed when the back button is pressed.
  ///
  final bool? dismissOnBack;

  ///
  /// Automatically show close button after ad duration time has passed ignoring pause events or video stalling.
  ///
  final bool? showCloseButtonAfterAdDuration;

  ///
  /// The amount of time to display the interstitial view before dismissing it automatically if no ad is loaded.
  ///
  final Duration? noAdTimeout;

  ///
  /// The amount of time to display the interstitial view before dismissing it automatically if video has stalled.
  ///
  final Duration? stalledVideoTimeout;

  ///
  /// The listener to be invoked when the interstitial view is dismissed.
  ///
  final void Function(AdPlayerInterstitialController)? onDismissListener;

  const AdPlayerInterstitialConfig({
    this.dismissOnBack,
    this.showCloseButtonAfterAdDuration,
    this.noAdTimeout,
    this.stalledVideoTimeout,
    this.onDismissListener,
  });

  Map<String, dynamic> toNative() {
    return {
      "dismissOnBack": dismissOnBack,
      "showCloseButtonAfterAdDuration": showCloseButtonAfterAdDuration,
      "noAdTimeout": noAdTimeout?.inMilliseconds,
      "stalledVideoTimeout": stalledVideoTimeout?.inMilliseconds,
    };
  }
}
