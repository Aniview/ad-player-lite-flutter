import 'package:ad_player_lite/ad_player_event.dart';
import 'package:ad_player_lite/ad_player_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const _methodChannel = MethodChannel("com.adservrs.adplayer.lite/AdPlayerController");
const _stateChannel = EventChannel("com.adservrs.adplayer.lite/AdPlayerController/State");
const _eventsChannel = EventChannel("com.adservrs.adplayer.lite/AdPlayerController/Events");

sealed class AdPlayerController {
  ///
  /// Unique id of this controller
  ///
  final String id;

  ///
  /// State changes stream
  ///
  late final state = _stateChannel.receiveBroadcastStream({'id': id}).map(AdPlayerState.fromNative);

  ///
  /// Events stream
  ///
  late final events = _eventsChannel.receiveBroadcastStream({'id': id}).map(AdPlayerEvent.fromNative);

  @internal
  AdPlayerController(this.id);

  ///
  /// Release all resources used by this controller.
  ///
  void dispose() {
    _methodChannel.invokeMethod("dispose", {"id": id});
  }

  ///
  /// Current player state.
  ///
  Future<AdPlayerState> getCurrentState() async {
    final result = await _methodChannel.invokeMethod("getCurrentState", {"id": id});
    return AdPlayerState.fromNative(result);
  }

  ///
  /// This method will pause the player if it's playing.
  ///
  void pause() {
    _methodChannel.invokeMethod("pause", {"id": id});
  }

  ///
  /// This method will resume the player if it's paused.
  ///
  void resume() {
    _methodChannel.invokeMethod("resume", {"id": id});
  }

  ///
  /// Invoking this method will skip the currently playing ad if there is one.
  ///
  void skipAd() {
    _methodChannel.invokeMethod("skipAd", {"id": id});
  }
}

class AdPlayerInReadController extends AdPlayerController {
  @internal
  AdPlayerInReadController(super.id);

  ///
  /// Move the player to or from the fullscreen display mode.
  ///
  void toggleFullscreen() {
    _methodChannel.invokeMethod("toggleFullscreen", {"id": id});
  }
}
