package com.adservrs.adplayer.lite.flutter.channels

import com.adservrs.adplayer.lite.AdPlayerController
import com.adservrs.adplayer.lite.AdPlayerInReadController
import com.adservrs.adplayer.lite.flutter.AdPlayerLiteRegistry
import com.adservrs.adplayer.lite.flutter.mappers.toFlutterValue
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

internal class AdPlayerControllerChannel(
    binding: FlutterPlugin.FlutterPluginBinding,
    private val registry: AdPlayerLiteRegistry,
) : MethodChannel.MethodCallHandler {
    private val channel = MethodChannel(
        binding.binaryMessenger,
        "com.adservrs.adplayer.lite/AdPlayerController",
    )

    init {
        channel.setMethodCallHandler(this)
    }

    fun release() {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val arguments = checkNotNull(call.arguments as? Map<*, *>) {
            "arguments is not a Map"
        }
        val controllerId = checkNotNull(arguments["id"] as? String) {
            "id is missing"
        }
        val controller = registry.getController(controllerId)

        return when (call.method) {
            // AdPlayerController
            "dispose" -> dispose(controllerId, result)
            "getCurrentState" -> getCurrentState(controller, result)
            "pause" -> pause(controller, result)
            "resume" -> resume(controller, result)
            "skipAd" -> skipAd(controller, result)
            // AdPlayerInReadController
            "toggleFullscreen" -> toggleFullscreen(controller, result)
            else -> result.notImplemented()
        }
    }

    private fun dispose(id: String, result: MethodChannel.Result) {
        registry.removeController(id)
        result.success(null)
    }

    private fun getCurrentState(controller: AdPlayerController, result: MethodChannel.Result) {
        val value = controller.state.value.toFlutterValue()
        result.success(value)
    }

    private fun pause(controller: AdPlayerController, result: MethodChannel.Result) {
        controller.pause()
        result.success(null)
    }

    private fun resume(controller: AdPlayerController, result: MethodChannel.Result) {
        controller.resume()
        result.success(null)
    }

    private fun skipAd(controller: AdPlayerController, result: MethodChannel.Result) {
        controller.skipAd()
        result.success(null)
    }

    private fun toggleFullscreen(controller: AdPlayerController, result: MethodChannel.Result) {
        if (controller is AdPlayerInReadController) {
            controller.toggleFullscreen()
        }
        result.success(null)
    }
}
