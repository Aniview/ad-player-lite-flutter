import Flutter
import AdPlayerLite

final class AdPlayerLiteMethodHandler {
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
        let channel = FlutterMethodChannel(name: "com.adservrs.adplayer.lite/AdPlayer", binaryMessenger: messenger)
        channel.setMethodCallHandler { [weak self] call, result in
            self?.handle(call, result: result)
        }
    }
    
    // MARK: - Handle method calls through channel
    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize":
            handleInitializeSDK(arguments: call.arguments, result: result)
        case "getVersion":
            result(moduleVersion)
        case "getTag":
            handleGetTag(arguments: call.arguments, result: result)
        default:
            result(FlutterError.notImplemented(name: call.method))
        }
    }
    
    // MARK: - Init 'AdPlayerLite' SDK
    private func handleInitializeSDK(arguments: Any?, result: @escaping FlutterResult) {
        guard let params = arguments as? [String: String],
              let storeURLString = params["iosStoreUrl"],
              let storeURL = URL(string: storeURLString)
        else {
            result(FlutterError.missingArguments())
            return
        }
        AdPlayer.initSDK(storeUrl: storeURL)
        result(nil)
    }
    
    // MARK: - create 'AdPlayerTag' object
    private func handleGetTag(arguments: Any?, result: @escaping FlutterResult) {
        guard let params = arguments as? [String: String],
              let pubId = params["pubId"],
              let tagId = params["tagId"],
              let registry = registry
        else {
            result(FlutterError.missingArguments())
            return
        }
        
        let tag = AdPlayer.getTag(pubId: pubId, tagId: tagId)
        let id = registry.addTag(tag)
        result(id)
    }
    
    // MARK: - Get version of plugin
    private var moduleVersion: String {
        Bundle(for: Self.self).object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
    }
}
