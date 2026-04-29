package com.adservrs.adplayer.lite.flutter.channels

import com.adservrs.adplayer.lite.flutter.AdPlayerLiteRegistry
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.collections.get

internal class AdPlayerTagChannel(
    binding: FlutterPlugin.FlutterPluginBinding,
    private val registry: AdPlayerLiteRegistry,
) : MethodChannel.MethodCallHandler {
    private val channel = MethodChannel(binding.binaryMessenger, "com.adservrs.adplayer.lite/AdPlayerTag")

    init {
        channel.setMethodCallHandler(this)
    }

    fun release() {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        return when (call.method) {
            "newInReadController" -> newInReadController(call, result)
            else -> result.notImplemented()
        }
    }

    private fun newInReadController(call: MethodCall, result: MethodChannel.Result) {
        val arguments = checkNotNull(call.arguments as? Map<*, *>) {
            "arguments is not a Map"
        }
        val id = checkNotNull(arguments["id"] as? String) {
            "pubId is missing"
        }

        val tag = registry.getTag(id)
        val controller = tag.newInReadController()
        val controllerId = registry.addController(controller)

        result.success(controllerId)
    }
}