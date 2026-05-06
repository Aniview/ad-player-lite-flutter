import 'package:ad_player_lite/ad_player_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ad_player_lite/ad_player.dart';
import 'package:ad_player_lite/adplayerinterstitial_controller_config.dart';

///
/// Tag object that is used to crate different controllers.
///
class AdPlayerTag {
  static const _channel =
      MethodChannel("com.adservrs.adplayer.lite/AdPlayerTag");

  final String id;

  @internal
  AdPlayerTag(this.id);

  Future<AdPlayerInReadController> newInReadController() async {
    final controllerId =
        await _channel.invokeMethod("newInReadController", {"id": id});

    return AdPlayerInReadController(controllerId as String);
  }

  Future<AdPlayerInterstitialController> newInterstitialController({
    InterstitialConfig? config,
  }) async {
      final args = <String, dynamic>{
        "id": id,
    };

    if (config != null) {
      args["config"] = config.toMap();
    }

    final controllerId = await _channel.invokeMethod(
      "newInterstitialController",
      args,
    );

    return AdPlayerInterstitialController(controllerId as String);
  }
}