import Flutter
import AdPlayerLite
#if canImport(DisplayAds)
import DisplayAds
#endif

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
            fatalError("Missing required parameter 'iosStoreUrl'. Please provide a valid App Store URL.")
        }
        AdPlayer.initSDK(storeUrl: storeURL)
        #if canImport(DisplayAds)
        AdPlayer.setDisplayProvider(DisplayAdsProvider())
        #endif
        result(nil)
    }
    
    // MARK: - create 'AdPlayerTag' object
    private func handleGetTag(arguments: Any?, result: @escaping FlutterResult) {
        guard let params = arguments as? [String: Any],
              let pubId = params["pubId"] as? String,
              let tagId = params["tagId"] as? String,
              let registry = registry
        else {
            result(FlutterError.missingArguments())
            return
        }
        let macros = params["macros"] as? [String: String] ?? [:]
        
        let tag = AdPlayer.getTag(pubId: pubId, tagId: tagId, macros: macros)
        let id = registry.addTag(tag)
        result(id)
    }
    
    // MARK: - Get version of plugin
    private var moduleVersion: String {
        Bundle(for: Self.self).object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
    }
}
