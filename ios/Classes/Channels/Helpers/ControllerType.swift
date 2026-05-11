//
//  AdPlayerControllerType.swift
//  ad_player_lite
//
//  Created by Zhanna Moskaliuk on 07.05.2026.
//

import AdPlayerLite

enum AdPlayerControllerType {
    case inRead(AdPlayerInReadController)
    case interstitial(AdPlayerInterstitialController)
    
    var inRead: AdPlayerInReadController? {
        guard case let .inRead(controller) = self else { return nil }
        return controller
    }
    
    var interstitial: AdPlayerInterstitialController? {
        guard case let .interstitial(controller) = self else { return nil }
        return controller
    }
}
