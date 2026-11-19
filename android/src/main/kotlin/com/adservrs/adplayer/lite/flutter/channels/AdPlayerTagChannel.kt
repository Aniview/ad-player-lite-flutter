package com.adservrs.adplayer.lite.flutter.channels

import android.net.Uri
import com.adservrs.adplayer.lite.AdPlayerInterstitialDismissListener
import com.adservrs.adplayer.lite.AdPlayerPreLoader
import com.adservrs.adplayer.lite.AdPlayerScaleType
import com.adservrs.adplayer.lite.flutter.AdPlayerLiteRegistry
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.time.Duration.Companion.milliseconds

internal class AdPlayerTagChannel(
    binding: FlutterPlugin.FlutterPluginBinding,
    private val registry: AdPlayerLiteRegistry,
) : MethodChannel.MethodCallHandler {
    private val tagChannelName = "com.adservrs.adplayer.lite/AdPlayerTag"
    private val tagChannel = MethodChannel(binding.binaryMessenger, tagChannelName)

    private val controllerChannelName = "com.adservrs.adplayer.lite/AdPlayerController"
    private val controllerChannel = MethodChannel(binding.binaryMessenger, controllerChannelName)

    init {
        tagChannel.setMethodCallHandler(this)
    }

    fun release() {
        tagChannel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "newInReadController" -> {
                newInReadController(call, result)
            }

            "newInterstitialController" -> {
                newInterstitialController(call, result)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    private fun newInReadController(call: MethodCall, result: MethodChannel.Result) {
        val arguments = checkNotNull(call.arguments as? Map<*, *>) {
            "arguments is not a Map"
        }
        val id = checkNotNull(arguments["id"] as? String) {
            "pubId is missing"
        }

        val preLoader = (arguments["preLoader"] as? Map<*, *>)?.let(::mapPreLoader)

        val tag = registry.getTag(id)
        val controllerId = registry.addController {
            tag.newInReadController { config -> config.preLoader = preLoader }
        }

        result.success(controllerId)
    }

    private fun newInterstitialController(call: MethodCall, result: MethodChannel.Result) {
        val arguments = checkNotNull(call.arguments as? Map<*, *>) {
            "arguments is not a Map"
        }
        val id = checkNotNull(arguments["id"] as? String) {
            "id is missing"
        }
        val config = checkNotNull(arguments["config"] as? Map<*, *>) {
            "config is not a Map"
        }

        val tag = registry.getTag(id)
        val controllerId = registry.addController { controllerId ->
            tag.newInterstitialController {
                it.dismissOnBack = config["dismissOnBack"] as? Boolean
                it.showCloseButtonAfterAdDuration = config["showCloseButtonAfterAdDuration"] as? Boolean
                it.noAdTimeout = (config["noAdTimeout"] as? Number)?.toLong()?.milliseconds
                it.stalledVideoTimeout = (config["stalledVideoTimeout"] as? Number)?.toLong()?.milliseconds
                it.onDismissListener = AdPlayerInterstitialDismissListener {
                    controllerChannel.invokeMethod("onInterstitialDismissed", mapOf("id" to controllerId))
                }
            }
        }
        result.success(controllerId)
    }

    private fun mapPreLoader(map: Map<*, *>): AdPlayerPreLoader? {
        if (map["type"] != "imageUrl") {
            return null
        }
        val imageUrl = map["imageUrl"] as? String ?: return null
        val scaleType = when (map["scaleType"]) {
            "fill" -> AdPlayerScaleType.Fill
            "contain" -> AdPlayerScaleType.Contain
            else -> AdPlayerScaleType.Cover
        }
        val clickListener = (map["clickThroughUrl"] as? String)?.let {
            AdPlayerPreLoader.clickThroughUrl(Uri.parse(it))
        }
        return AdPlayerPreLoader.ImageUrl(
            imageUrl = imageUrl,
            scaleType = scaleType,
            clickListener = clickListener,
        )
    }
}
