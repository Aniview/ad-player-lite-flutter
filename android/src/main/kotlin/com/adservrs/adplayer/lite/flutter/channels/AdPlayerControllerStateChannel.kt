package com.adservrs.adplayer.lite.flutter.channels

import com.adservrs.adplayer.lite.AdPlayerController
import com.adservrs.adplayer.lite.flutter.AdPlayerLiteRegistry
import com.adservrs.adplayer.lite.flutter.mappers.toFlutterValue
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.Job
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import java.util.concurrent.atomic.AtomicReference

internal class AdPlayerControllerStateChannel(
    binding: FlutterPlugin.FlutterPluginBinding,
    private val registry: AdPlayerLiteRegistry,
) : EventChannel.StreamHandler {
    private val coroutineScope = MainScope()
    private val currentJob = AtomicReference<Job?>(null)
    private val channel = EventChannel(
        binding.binaryMessenger,
        "com.adservrs.adplayer.lite/AdPlayerController/State",
    )

    init {
        channel.setStreamHandler(this)
    }

    fun release() {
        coroutineScope.cancel()
        channel.setStreamHandler(null)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
        val arguments = checkNotNull(arguments as? Map<*, *>) {
            "arguments is not a Map"
        }
        val controllerId = checkNotNull(arguments["id"] as? String) {
            "id is missing"
        }
        val controller: AdPlayerController = registry.getController(controllerId)
        val job = coroutineScope.launch {
            controller.state.collect {
                events.success(it.toFlutterValue())
            }
        }
        currentJob.getAndSet(job)?.cancel()
    }

    override fun onCancel(arguments: Any?) {
        currentJob.getAndSet(null)?.cancel()
    }
}
