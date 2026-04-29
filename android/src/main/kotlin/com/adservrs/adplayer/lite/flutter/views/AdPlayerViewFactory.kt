package com.adservrs.adplayer.lite.flutter.views

import android.content.Context
import android.view.View
import com.adservrs.adplayer.lite.AdPlayerInReadController
import com.adservrs.adplayer.lite.AdPlayerView
import com.adservrs.adplayer.lite.flutter.AdPlayerLiteRegistry
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

internal class AdPlayerViewFactory(
    private val registry: AdPlayerLiteRegistry,
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val arguments = checkNotNull(args as? Map<*, *>) {
            "arguments is not a Map"
        }
        val controllerId = checkNotNull(arguments["controllerId"] as? String) {
            "controllerId is missing"
        }
        val controller = registry.getController(controllerId) as AdPlayerInReadController
        val view = AdPlayerView(context)
        view.attachController(controller)

        return object : PlatformView {
            override fun getView(): View {
                return view
            }

            override fun dispose() {
                view.detachController()
            }
        }
    }
}
