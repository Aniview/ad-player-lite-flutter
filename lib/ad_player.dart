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
  /// [iosStoreUrl] is the App Store URL of the app (required on iOS).
  ///
  static AdPlayer initialize({String? iosStoreUrl}) {
    if (!_initialized) {
      _channel.invokeMethod("initialize", {
        "iosStoreUrl": iosStoreUrl,
      });
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
  /// [macros] are optional custom key/value pairs (e.g. per-user values or
  /// targeting) that are passed to the native SDK and sent with every ad request
  /// made by this tag.
  ///
  /// [domain] is an optional publisher app domain, used as is. The player is loaded
  /// with it and it is sent with ad requests made by this tag. Defaults to "aniview.com".
  ///
  Future<AdPlayerTag> getTag({
    required String pubId,
    required String tagId,
    Map<String, String> macros = const {},
    String? domain,
  }) async {
    final id = await _channel.invokeMethod("getTag", {
      "pubId": pubId,
      "tagId": tagId,
      "macros": macros,
      if (domain != null) "domain": domain,
    });
    return AdPlayerTag(id as String);
  }
}
