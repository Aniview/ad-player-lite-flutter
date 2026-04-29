package com.adservrs.adplayer.lite.flutter

import com.adservrs.adplayer.lite.flutter.channels.AdPlayerChannel
import com.adservrs.adplayer.lite.flutter.channels.AdPlayerControllerChannel
import com.adservrs.adplayer.lite.flutter.channels.AdPlayerControllerEventsChannel
import com.adservrs.adplayer.lite.flutter.channels.AdPlayerControllerStateChannel
import com.adservrs.adplayer.lite.flutter.channels.AdPlayerTagChannel
import com.adservrs.adplayer.lite.flutter.views.AdPlayerViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin

internal class AdPlayerLiteFlutterPlugin : FlutterPlugin {
    private val registry = AdPlayerLiteRegistry()

    private lateinit var adPlayerChannel: AdPlayerChannel
    private lateinit var adPlayerTagChannel: AdPlayerTagChannel
    private lateinit var adPlayerControllerChannel: AdPlayerControllerChannel
    private lateinit var adPlayerControllerStateChannel: AdPlayerControllerStateChannel
    private lateinit var adPlayerControllerEventsChannel: AdPlayerControllerEventsChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        adPlayerChannel = AdPlayerChannel(binding, registry)
        adPlayerTagChannel = AdPlayerTagChannel(binding, registry)
        adPlayerControllerChannel = AdPlayerControllerChannel(binding, registry)
        adPlayerControllerStateChannel = AdPlayerControllerStateChannel(binding, registry)
        adPlayerControllerEventsChannel = AdPlayerControllerEventsChannel(binding, registry)

        binding.platformViewRegistry.registerViewFactory(
            "AdPlayerView",
            AdPlayerViewFactory(registry)
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        adPlayerChannel.release()
        adPlayerTagChannel.release()
        adPlayerControllerChannel.release()
        adPlayerControllerStateChannel.release()
        adPlayerControllerEventsChannel.release()

        registry.release()
    }
}
