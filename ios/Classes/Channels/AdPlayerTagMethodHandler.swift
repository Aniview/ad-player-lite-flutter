import Flutter
import AdPlayerLite

final class AdPlayerTagMethodHandler {
    private var registry: ControllerRegistry?
    private var messenger: FlutterBinaryMessenger?
    private var controller: AdPlayerController?
    private var channel: FlutterMethodChannel?
    
    // MARK: - Registration
    func registerChannel(
        _ registrar: FlutterPluginRegistrar,
        registry: ControllerRegistry,
        messenger: FlutterBinaryMessenger
    ) {
        self.registry = registry
        self.messenger = messenger
        channel = FlutterMethodChannel(name: "com.adservrs.adplayer.lite/AdPlayerTag", binaryMessenger: messenger)
        channel?.setMethodCallHandler { [weak self] call, result in
            self?.handle(call, result: result)
        }
    }
    
    // MARK: - Handle method calls through channel
    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "newInReadController":
            newInReadController(arguments: call.arguments, result: result)
        case "newInterstitialController":
            newInterstitialController(arguments: call.arguments, result: result)
        default:
            result(FlutterError.notImplemented(name: call.method))
        }
    }
    
    // MARK: - Create new 'in-read' controller object from registered tag
    private func newInReadController(arguments: Any?, result: @escaping FlutterResult) {
        guard let params = arguments as? [String: String],
              let id = params["id"],
              let registry = registry
        else {
            result(FlutterError.missingArguments())
            return
        }
        guard let tag = registry.getTag(id) else {
            result(FlutterError.missingArguments())
            return
        }
        let controller = tag.newInReadController()
        let controllerId = registry.addController(.inRead(controller))
        result(controllerId)
    }
    
    // MARK: - Create new 'interstitial' controller
    private func newInterstitialController(arguments: Any?, result: @escaping FlutterResult) {
        guard let params = arguments as? [String: Any],
              let id = params["id"] as? String,
              let registry = registry
        else {
            result(FlutterError.missingArguments())
            return
        }
        guard let tag = registry.getTag(id) else {
            result(FlutterError.missingArguments())
            return
        }
        
        var controllerId: String?
        let controller = tag.newInterstitialController(configuration: mapConfig(params)) { [weak self] in
            if let id = controllerId {
                self?.channel?.invokeMethod("onInterstitialDismissed", arguments: ["id": id])
            }
        }
        controllerId = registry.addController(.interstitial(controller))
        result(controllerId)
    }
    
    // MARK: - Parse config received from flutter 'arguments'
    private func mapConfig(_ params: [String: Any]) -> AdPlayerInterstitialConfiguration? {
        guard let config = params["config"] as? [String: Any],
              let noAdTimeout = config["noAdTimeout"] as? Double,
              let showCloseButtonAfterAdDuration = config["showCloseButtonAfterAdDuration"] as? Bool
        else { return nil }
        
        let stalledVideoTimeout = config["stalledVideoTimeout"] as? Double
        
        let congiguration = AdPlayerInterstitialConfiguration(
            noAdTimeout: noAdTimeout,
            stalledVideoTimeout: stalledVideoTimeout,
            showCloseButtonAfterAdDuration: showCloseButtonAfterAdDuration
        )
        return congiguration
    }
}
