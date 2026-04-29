import AdPlayerLite

extension AdPlayerEvent {
    
    var name: String {
        switch self {
            
        case .inventory:
            return "Inventory"
            
        case .adSourceLoaded:
            return "AdSourceLoaded"
            
        case .adImpression:
            return "AdImpression"
            
        case .adPlaying:
            return "AdPlaying"
            
        case .adPaused:
            return "AdPaused"
            
        case .adVideoFirstQuartile:
            return "AdVideoFirstQuartile"
            
        case .adVideoMidpoint:
            return "AdVideoMidpoint"
            
        case .adVideoThirdQuartile:
            return "AdVideoThirdQuartile"
            
        case .adVideoCompleted:
            return "AdVideoComplete"
            
        case .adSkipped:
            return "AdSkipped"
            
        case .allAdsFinished:
            return "AdWaterfallEnd"
            
        case .adDurationChange:
            return "AdDurationChange"
            
        case .adVolumeChange:
            return "AdVolumeChange"
            
        case .onContentTimeChange:
            return "AdVideoTimeChanged"
            
        case .onContentError:
            return "ContentError"
            
        case .contentVideoStart:
            return "ContentVideoStart"
            
        case .contentPlaying:
            return "ContentPlaying"
            
        case .contentPaused:
            return "ContentPaused"
            
        case .contentClick:
            return "ContentClicked"
            
        case .contentVideoFirstQuartile:
            return "ContentVideoFirstQuartile"
            
        case .contentVideoMidpoint:
            return "ContentVideoMidpoint"
            
        case .contentVideoThirdQuartile:
            return "ContentVideoThirdQuartile"
            
        case .contentVideoCompleted:
            return "ContentVideoComplete"
            
        case .contentVolumeChange:
            return "ContentVolumeChange"
            
        case .adError:
            return "AdError"
            
        case .adClickThrough:
            return "AdClickThrough"
            
        case .closed:
            return "Close"
        }
    }
}

extension AdPlayerEvent {
    
    var asMap: [String: Any] {
        
        var map: [String: Any] = [
            "name": name
        ]
        
        switch self {
            
            // MARK: - simple events
        case .inventory,
                .adSourceLoaded,
                .adPlaying,
                .adPaused,
                .adVideoFirstQuartile,
                .adVideoMidpoint,
                .adVideoThirdQuartile,
                .allAdsFinished,
                .adClickThrough,
                .closed,
                .contentVideoStart,
                .contentPlaying,
                .contentPaused,
                .contentClick,
                .contentVideoFirstQuartile,
                .contentVideoMidpoint,
                .contentVideoThirdQuartile,
                .contentVideoCompleted:
            break
            
            // MARK: - AdImpression (FIXED: must match Flutter "data")
        case .adImpression:
            map["data"] = ""
            
            // MARK: - AdVolumeChange
        case .adVolumeChange(let volume):
            map["volume"] = Double(volume)
            
        case .contentVolumeChange(let volume):
            map["volume"] = Double(volume)
            
            // MARK: - AdDurationChange
        case .adDurationChange(let duration):
            map["duration"] = Int(duration * 1000)
            
            // MARK: - Time change
        case .onContentTimeChange(let current, let duration):
            map["position"] = Int(current * 1000)
            map["duration"] = Int(duration * 1000)
            
            // MARK: - Errors
        case .adError:
            map["message"] = "ad error"
            
        case .onContentError(let error):
            map["message"] = error
            
            // MARK: - Companion flags
        case .adVideoCompleted(let showCompanion):
            map["showCompanion"] = showCompanion
            
        case .adSkipped(let showCompanion):
            map["showCompanion"] = showCompanion
        }
        
        return map
    }
}
