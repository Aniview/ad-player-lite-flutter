import Flutter
import AdPlayerLite

final class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger
    private let registry: ControllerRegistry

    init(messenger: FlutterBinaryMessenger, registry: ControllerRegistry) {
        self.messenger = messenger
        self.registry = registry
        super.init()
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }

    // MARK: - Create 'PlacementView'
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        guard let dict = args as? [String: Any],
              let controllerId = dict["controllerId"] as? String,
              let controller = registry.getController(controllerId)?.inRead
        else {
            fatalError("AdPlacementView requires a registered controllerId")
        }
        return AdPlayerFlutterPlatformView(frame: frame, controller: controller)
    }
}
