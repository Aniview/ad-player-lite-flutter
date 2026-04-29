import Flutter
import Combine

final class AdPlayerLiteEventsHandler: NSObject, FlutterStreamHandler {
    private var registry: ControllerRegistry?
    private var eventsSink: FlutterEventSink?
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Registration
    func registerChannel(_ registrar: FlutterPluginRegistrar, registry: ControllerRegistry) {
        let channel = FlutterEventChannel(
            name: "com.adservrs.adplayer.lite/AdPlayerController/Events",
            binaryMessenger: registrar.messenger()
        )
        self.registry = registry
        channel.setStreamHandler(self)
    }
    
    // MARK: - Called from Flutter
    func onListen(withArguments arguments: Any?,
                  eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        self.eventsSink = events
        
        guard let args = arguments as? [String: Any],
              let playerId = args["id"] as? String else {
            return FlutterError.missingArguments()
        }
        
        startPublisher(withId: playerId)
        return nil
    }
    
    // MARK: - Called from Flutter
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        stopPublisher()
        eventsSink = nil
        return nil
    }
    
    // MARK: - Combine bridge
    private func startPublisher(withId: String) {
        guard let _ = eventsSink else {
            return
        }
        stopPublisher() // prevent duplicates
        // get controller by 'id' from 'registry'
        guard let controller = registry?.getController(withId) else {
            eventsSink?(FlutterError.missingArguments())
            return
        }
        // subscribe to 'eventsPublisher'
        controller.eventsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                self?.eventsSink?(event.asMap)
            }
            .store(in: &cancellables)
    }
    
    private func stopPublisher() {
        cancellables.removeAll()
    }
}
