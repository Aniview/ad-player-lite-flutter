import 'package:ad_player_lite/ad_player_tag.dart';
import 'package:flutter/services.dart';
import 'package:ad_player_lite/adplayerinterstitial_controller_config.dart';

///
/// Global object responsible for creating tags.
///
class AdPlayer {
  static const _channel = MethodChannel("com.adservrs.adplayer.lite/AdPlayer");
  static var initialized = false;

  const AdPlayer._();

  ///
  /// Initialize instance of the AdPlayer.
  ///
  static AdPlayer initialize({String? iosStoreUrl}) {
    if (!initialized) {
      _channel.invokeMethod("initialize", {
        "iosStoreUrl": iosStoreUrl,
      });
      initialized = true;
    }
    return const AdPlayer._();
  }

  ///
  /// Returns current version of plagin
  ///
  static Future<String> getVersion() async {
    return await _channel.invokeMethod<String>("getVersion") ?? "unknown";
  }

  ///
  /// Returns tag for specific configuration.
  /// Tags are cached and calling with method with the same arguments will always return the same object.
  ///
  Future<AdPlayerTag> getTag({
    required String pubId,
    required String tagId,
  }) async {
    final id = await _channel.invokeMethod("getTag", {
      "pubId": pubId,
      "tagId": tagId,
    });
    return AdPlayerTag(id as String);
  }
}

extension AdPlayerInterstitial on AdPlayer {
  Future<void> showInterstitial({
    required String pubId,
    required String tagId,
    InterstitialConfig? config,
  }) async {
    final tag = await getTag(pubId: pubId, tagId: tagId);

    final controller = await tag.newInterstitialController(config: config);

    controller.launchInterstitial();
  }
}

// extension AdPlayerInterstitial on AdPlayer {
//   Future<void> showInterstitial({
//     required String pubId,
//     required String tagId,
//     required InterstitialConfig config,
//   }) async {
//     final tag = await getTag(pubId: pubId, tagId: tagId);
//     final interstitialController = await tag.newInterstitialController();

//     // Pass config where needed (example)
//     interstitialController.launchInterstitial(config.toMap());
//   }
// }