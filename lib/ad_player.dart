import 'package:ad_player_lite/ad_player_tag.dart';
import 'package:flutter/services.dart';

///
/// Global object responsible for creating tags.
///
class AdPlayer {
  static const _channel = MethodChannel("com.adservrs.adplayer.lite/AdPlayer");
  static var _initialized = false;

  const AdPlayer._();

  ///
  /// Initialize instance of the AdPlayer.
  ///
  static AdPlayer initialize({String? iosStoreUrl}) {
    if (!_initialized) {
      _channel.invokeMethod("initialize", {"iosStoreUrl": iosStoreUrl});
      _initialized = true;
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
  Future<AdPlayerTag> getTag({required String pubId, required String tagId}) async {
    final id = await _channel.invokeMethod("getTag", {"pubId": pubId, "tagId": tagId});
    return AdPlayerTag(id as String);
  }
}
