//
//  StatePublisherHelpers.swift
//  adplayerlite_flutter_plugin
//
//  Created by Zhanna Moskaliuk on 24.04.2026.
//

import AdPlayerLite

extension AdPlayerState {

    var flutterName: String {
        switch self {
        case .preparing: return "Preparing"
        case .ready: return "Ready"
        case .playingAd: return "PlayingAdVideo"
        case .playingContent: return "PlayingContent"
        case .notPlaying: return "NotPlaying"
        case .display: return "Display"
        @unknown default:
            return "NotPlaying"
        }
    }
}
