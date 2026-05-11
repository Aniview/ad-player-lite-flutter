package com.adservrs.adplayer.lite.flutter

import com.adservrs.adplayer.lite.AdPlayerController
import com.adservrs.adplayer.lite.AdPlayerTag
import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.atomic.AtomicLong

internal class AdPlayerLiteRegistry {
    private val tags = ConcurrentHashMap<String, AdPlayerTag>()

    private var controllerIdCounter = AtomicLong()
    private val controllers = ConcurrentHashMap<String, AdPlayerController>()

    fun release() {
        for (controller in controllers.values) {
            controller.release()
        }
    }

    fun addTag(tag: AdPlayerTag): String {
        val id = tag.hashCode().toString()
        tags[id] = tag
        return id
    }

    fun getTag(id: String): AdPlayerTag {
        return checkNotNull(tags[id]) {
            "tag not found: id = $id"
        }
    }

    fun addController(block: (String) -> AdPlayerController): String {
        val id = controllerIdCounter.incrementAndGet().toString()
        controllers[id] = block(id)
        return id
    }

    fun getController(id: String): AdPlayerController {
        return checkNotNull(controllers[id]) {
            "controller not found: id = $id"
        }
    }

    fun removeController(id: String): AdPlayerController {
        return checkNotNull(controllers.remove(id)) {
            "controller not found: id = $id"
        }
    }
}
