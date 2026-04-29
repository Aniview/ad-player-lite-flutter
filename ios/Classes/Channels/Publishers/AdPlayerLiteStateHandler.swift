//
//  AdPlayerLiteStateHandler.swift
//  ad_player_lite
//
//  Created by Zhanna Moskaliuk on 23.04.2026.
//

import Foundation
import Combine
import Flutter

final class AdPlayerLiteStateHandler: NSObject, FlutterStreamHandler {
    
    private var registry: ControllerRegistry?
    private var stateSink: FlutterEventSink?
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Registration
    func registerChannel(_ registrar: FlutterPluginRegistrar, registry: ControllerRegistry) {
        let channel = FlutterEventChannel(
            name: "com.adservrs.adplayer.lite/AdPlayerController/State",
            binaryMessenger: registrar.messenger()
        )
        self.registry = registry
        channel.setStreamHandler(self)
    }
    
    // MARK: - Called from Flutter
    func onListen(withArguments arguments: Any?,
                  eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        self.stateSink = events
        
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
        stateSink = nil
        return nil
    }
    
    // MARK: - Combine bridge
    private func startPublisher(withId: String) {
        guard let _ = stateSink else {
            return
        }
        stopPublisher() // prevent duplicates
        // get controller by 'id' from 'registry'
        guard let controller = registry?.getController(withId) else {
            stateSink?(FlutterError.missingArguments())
            return
        }
        // subscribe to 'statePublisher'
        controller.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.stateSink?(state.flutterName)
            }
            .store(in: &cancellables)
    }
    
    private func stopPublisher() {
        cancellables.removeAll()
    }
}
