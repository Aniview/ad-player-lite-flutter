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
  /// [domain] is an optional publisher app domain (e.g. "fluttertest.tv"). When set,
  /// ad requests on both platforms report it as the app domain instead of
  /// aniview.com. When `null` or empty, the native SDK default is used.
  /// Must be called before [getTag]: tags created earlier keep the default domain.
  ///
  static AdPlayer initialize({String? iosStoreUrl, String? domain}) {
    if (!_initialized) {
      final trimmedDomain = domain?.trim();
      _channel.invokeMethod("initialize", {
        "iosStoreUrl": iosStoreUrl,
        if (trimmedDomain != null && trimmedDomain.isNotEmpty) "domain": trimmedDomain,
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
  Future<AdPlayerTag> getTag({
    required String pubId,
    required String tagId,
    Map<String, String> macros = const {},
  }) async {
    final id = await _channel.invokeMethod("getTag", {
      "pubId": pubId,
      "tagId": tagId,
      "macros": macros,
    });
    return AdPlayerTag(id as String);
  }
}
