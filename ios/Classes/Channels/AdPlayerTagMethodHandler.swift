import Flutter
import AdPlayerLite

final class AdPlayerTagMethodHandler {
    private var registry: ControllerRegistry?
    private var messenger: FlutterBinaryMessenger?
    private var controller: AdPlayerController?
    
    // MARK: - Registration
    func registerChannel(
        _ registrar: FlutterPluginRegistrar,
        registry: ControllerRegistry,
        messenger: FlutterBinaryMessenger
    ) {
        self.registry = registry
        self.messenger = messenger
        let channel = FlutterMethodChannel(name: "com.adservrs.adplayer.lite/AdPlayerTag", binaryMessenger: messenger)
        channel.setMethodCallHandler { [weak self] call, result in
            self?.handle(call, result: result)
        }
    }
    
    // MARK: - Handle method calls through channel
    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "newInReadController":
            newInReadController(arguments: call.arguments, result: result)
        default:
            result(FlutterError.notImplemented(name: call.method))
        }
    }
    
    // MARK: - Create 'controller' object from registered tag
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
        let controllerId = registry.addController(controller)
        result(controllerId)
    }
}
