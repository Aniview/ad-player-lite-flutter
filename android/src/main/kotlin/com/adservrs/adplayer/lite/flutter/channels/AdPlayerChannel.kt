package com.adservrs.adplayer.lite.flutter.channels

import com.adservrs.adplayer.lite.AdPlayer
import com.adservrs.adplayer.lite.BuildConfig
import com.adservrs.adplayer.lite.flutter.AdPlayerLiteRegistry
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

internal class AdPlayerChannel(
    binding: FlutterPlugin.FlutterPluginBinding,
    private val registry: AdPlayerLiteRegistry,
) : MethodChannel.MethodCallHandler {
    private val context = binding.applicationContext
    private val channel = MethodChannel(binding.binaryMessenger, "com.adservrs.adplayer.lite/AdPlayer")

    init {
        channel.setMethodCallHandler(this)
    }

    fun release() {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        return when (call.method) {
            "initialize" -> result.success(null)
            "getVersion" -> result.success(BuildConfig.SDK_VERSION_NAME)
            "getTag" -> getTag(call, result)
            else -> result.notImplemented()
        }
    }

    private fun getTag(call: MethodCall, result: MethodChannel.Result) {
        val arguments = checkNotNull(call.arguments as? Map<*, *>) {
            "arguments is not a Map"
        }
        val pubId = checkNotNull(arguments["pubId"] as? String) {
            "pubId is missing"
        }
        val tagId = checkNotNull(arguments["tagId"] as? String) {
            "tagId is missing"
        }

        val tag = AdPlayer.getTag(context, pubId = pubId, tagId = tagId)
        val id = registry.addTag(tag)

        result.success(id)
    }
}