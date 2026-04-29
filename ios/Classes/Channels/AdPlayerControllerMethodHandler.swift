import Flutter
import AdPlayerLite

final class AdPlayerControllerMethodHandler {
    private var registry: ControllerRegistry?
    private var messenger: FlutterBinaryMessenger?
    
    // MARK: - Registration
    func registerChannel(
        _ registrar: FlutterPluginRegistrar,
        registry: ControllerRegistry,
        messenger: FlutterBinaryMessenger
    ) {
        self.registry = registry
        self.messenger = messenger
        let channel = FlutterMethodChannel(name: "com.adservrs.adplayer.lite/AdPlayerController", binaryMessenger: messenger)
        channel.setMethodCallHandler { [weak self] call, result in
            self?.handle(call, result: result)
        }
    }
    
    // MARK: - Handle method calls through channel
    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "resume":
            handleResume(arguments: call.arguments, result: result)
        case "pause":
            handlePause(arguments: call.arguments, result: result)
        case "getCurrentState":
            handleGetCurrentState(arguments: call.arguments, result: result)
        case "toggleFullscreen":
            handleToggleFullscreen(arguments: call.arguments, result: result)
        case "skipAd":
            handleSkipAd(arguments: call.arguments, result: result)
        default:
            result(FlutterError.notImplemented(name: call.method))
        }
    }
    
    private func handleResume(arguments: Any?, result: @escaping FlutterResult) {
        guard let params = arguments as? [String: String],
              let controllerId = params["id"],
              let registry = registry
        else {
            result(FlutterError.missingArguments())
            return
        }
        guard let controller = registry.getController(controllerId) else {
            result(FlutterError.controllerIsMissing())
            return
        }
        controller.resume()
        result(nil)
    }
    
    private func handlePause(arguments: Any?, result: @escaping FlutterResult) {
        guard let params = arguments as? [String: String],
              let controllerId = params["id"],
              let registry = registry
        else {
            result(FlutterError.missingArguments())
            return
        }
        guard let controller = registry.getController(controllerId) else {
            result(FlutterError.controllerIsMissing())
            return
        }
        controller.pause()
        result(nil)
    }
    
    private func handleGetCurrentState(arguments: Any?, result: @escaping FlutterResult) {
        guard let params = arguments as? [String: String],
              let controllerId = params["id"],
              let registry = registry
        else {
            result(FlutterError.missingArguments())
            return
        }
        guard let controller = registry.getController(controllerId) else {
            result(FlutterError.controllerIsMissing())
            return
        }
        let state = controller.state.flutterName
        result(state)
    }
    
    private func handleToggleFullscreen(arguments: Any?, result: @escaping FlutterResult) {
        guard let params = arguments as? [String: String],
              let controllerId = params["id"],
              let registry = registry
        else {
            result(FlutterError.missingArguments())
            return
        }
        guard let controller = registry.getController(controllerId) else {
            result(FlutterError.controllerIsMissing())
            return
        }
        controller.toggleFullscreen()
        result(nil)
    }
    
    private func handleSkipAd(arguments: Any?, result: @escaping FlutterResult) {
        guard let params = arguments as? [String: String],
              let controllerId = params["id"],
              let registry = registry
        else {
            result(FlutterError.missingArguments())
            return
        }
        guard let controller = registry.getController(controllerId) else {
            result(FlutterError.controllerIsMissing())
            return
        }
        controller.skipAd()
        result(nil)
    }
}
