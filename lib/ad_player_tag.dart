import 'package:ad_player_lite/ad_player_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

///
/// Tag object that is used to crate different controllers.
///
class AdPlayerTag {
  static const _channel = MethodChannel("com.adservrs.adplayer.lite/AdPlayerTag");

  final String id;

  @internal
  AdPlayerTag(this.id);

  ///
  /// Returns new controller for in-read ads.
  /// This controller **must** be released when no longer needed.
  ///
  Future<AdPlayerInReadController> newInReadController() async {
    final controllerId = await _channel.invokeMethod("newInReadController", {"id": id});
    return AdPlayerInReadController(controllerId as String);
  }
}
