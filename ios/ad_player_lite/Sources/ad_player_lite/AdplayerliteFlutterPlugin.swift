import Flutter
import UIKit
import AdPlayerLite

public final class AdplayerliteFlutterPlugin: NSObject {
    private static var instance = AdplayerliteFlutterPlugin()
    private let registry = ControllerRegistry()
    
    // method handlers
    private lazy var playerMethodHandler = AdPlayerLiteMethodHandler()
    private lazy var adPlayerTagHandler = AdPlayerTagMethodHandler()
    private lazy var adPlayerControllerHandler = AdPlayerControllerMethodHandler()
    
    // publisher handlers
    private lazy var playerEventsHandler = AdPlayerLiteEventsHandler()
    private lazy var playerStateHandler = AdPlayerLiteStateHandler()
}

extension AdplayerliteFlutterPlugin: FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger = registrar.messenger()
        
        // basic method handler (SDK level)
        instance.playerMethodHandler.registerChannel(
            registrar,
            registry: instance.registry,
            messenger: messenger
        )
        
        // 'AdPlayerTag' method handler
        instance.adPlayerTagHandler.registerChannel(
            registrar,
            registry: instance.registry,
            messenger: messenger
        )
        
        // 'AdPlayerController' method handler
        instance.adPlayerControllerHandler.registerChannel(
            registrar,
            registry: instance.registry,
            messenger: messenger
        )
        
        // register publishers
        instance.playerEventsHandler.registerChannel(registrar, registry: instance.registry)
        instance.playerStateHandler.registerChannel(registrar, registry: instance.registry)
        
        // view registration
        registrar.register(
            FLNativeViewFactory(messenger: messenger, registry: instance.registry),
            withId: "AdPlacementView"
        )
    }
}
