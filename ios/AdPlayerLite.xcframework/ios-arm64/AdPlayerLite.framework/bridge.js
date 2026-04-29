Bridge = {
    setSize: function(width, height) {
        if (sdkOptions.isOutstream) {
            player.resize(width, height);
        } else {
            player.setSize(width, height);
        }
    },
    debugLog: function(message) {
        webkit.messageHandlers.debugLog.postMessage(message)
    },
    setViewability: function(viewability) {
      if (player && player.setViewability) {
        player.setViewability(viewability);
      }
    },
    getContent: function() {
        return player.config.content.contents.map((e) => {
            return {
                "id": e.id,
                "name": e.name,
                "thumbnail": e.thumbnail,
                "description": e.description,
            };
        });
    }
};

nativeAds = {
    duration: 0,
    isSkippable: false
};

window.sdkCtx = 1;
var eventCallbacks = {};
window.eventDispatcher = {
  addListener: function(context, callback) {
    eventCallbacks[context] = callback;
  },
  removeListener: function(context) {
    if(eventCallbacks[context])
      delete eventCallbacks[context];
  },
  dispatch: function(context, event, data) {
    if(eventCallbacks[context])
        eventCallbacks[context](event, data);
    }
};

var renderer = {}
aniviewRenderer = renderer;

renderer.preparePlayer = function(p) {
    player = p;

    if (sdkAdConfig) {
        p.setAdConfig(sdkAdConfig);
    }
    if (sdkContentConfig) {
        p.mergeConfig(sdkContentConfig);
    }

    p.on("Inventory", function(data){
        webkit.messageHandlers.onInventory.postMessage("")
    });

    p.on("AdReady", function() {
        webkit.messageHandlers.onAdReady.postMessage("")
    });

    p.on("AdLoaded", function(){
        webkit.messageHandlers.onAdLoaded.postMessage("")
    });
    p.on("AdImpression", function(imp) {
        var data = JSON.stringify(imp);
        webkit.messageHandlers.onAdImpression.postMessage(JSON.stringify(imp));
    });
    p.on("AdViewableImpression", function(){
        webkit.messageHandlers.onAdViewableImpression.postMessage("")
    });
    p.on("AdStarted", function(){
        Bridge.debugLog("AdStarted")
    });

    p.on("AdStopped", function(){
        Bridge.debugLog("AdStarted")
    });

    p.on("AdVideoStart", function(){
        webkit.messageHandlers.onAdVideoStart.postMessage("");
    });

    p.on("AdVideoFirstQuartile", function(){
        webkit.messageHandlers.onAdVideoFirstQuartile.postMessage("");
    });

    p.on("AdVideoMidpoint", function(){
        webkit.messageHandlers.onAdVideoMidpoint.postMessage("");
    });

    p.on("AdVideoThirdQuartile", function(){
        webkit.messageHandlers.onAdVideoThirdQuartile.postMessage("");
    });

    p.on("AdVideoComplete", function(data) {
        webkit.messageHandlers.onAdVideoComplete.postMessage(data.showCompanion);
    });

    p.on("AdClickThru", function(data){
        webkit.messageHandlers.onClickThrough.postMessage(JSON.stringify(data));
    });

    p.on("AdSkipped", function(data){
        webkit.messageHandlers.onAdSkipped.postMessage(data.showCompanion);
    });

    p.on("AdSkippableStateChange", function(){
        webkit.messageHandlers.onSkipAvailable.postMessage("");
    });

    p.on("AdPaused", function(){
        webkit.messageHandlers.onAdPaused.postMessage("");
    });

    p.on("AdPlaying", function(){
        webkit.messageHandlers.onAdPlaying.postMessage("");
    });

    p.on("AdDurationChange", function() {
        webkit.messageHandlers.onAdDurationChange.postMessage(player.getAdDuration());
    });

    p.on("AdVolumeChange", function(){
        var adVolume = sdkOptions.isOutstream ? player.getAdVolume() : player.getVolume();
        webkit.messageHandlers.onAdVolumeChange.postMessage(adVolume);
    });

    p.on("AdSizeChange", function(){
        Bridge.debugLog("AdSizeChange: " + player.getWidth() + " , " + player.getHeight())
    });

    p.on("AdError", function(err) {
        Bridge.debugLog(JSON.stringify(err, null, 2));
        var data = sdkOptions.isOutstream ? err : err.data;
        var errorLimit = data.errorlimit || data.errorLimit;
        webkit.messageHandlers.onAdError.postMessage({ errorLimit: errorLimit, reason: data.reason });
    });

    p.on("ContentPauseClicked", function(){
        webkit.messageHandlers.onContentPauseClicked.postMessage("");
    });

    p.on("ContentPlayClicked", function(){
        webkit.messageHandlers.onContentPlayClicked.postMessage("");
    });

    p.on("ContentPaused", function(){
        webkit.messageHandlers.onContentPaused.postMessage("");
    });

    p.on("ContentPlaying", function(){
        webkit.messageHandlers.onContentPlaying.postMessage(JSON.stringify(player.getCurrentContent()));
    });

    p.on("ContentVolumeChange", function(){
        webkit.messageHandlers.onContentVolumeChange.postMessage(player.getVolume());
    });

    p.on("ContentVideoStart", function(){
        webkit.messageHandlers.onContentVideoStart.postMessage("");
    });
    p.on("ContentVideoFirstQuartile", function(){
        webkit.messageHandlers.onContentVideoFirstQuartile.postMessage("");
    });
    p.on("ContentVideoMidpoint", function(){
        webkit.messageHandlers.onContentVideoMidpoint.postMessage("");
    });
    p.on("ContentVideoThirdQuartile", function(){
        webkit.messageHandlers.onContentVideoThirdQuartile.postMessage("");
    });
    
    p.on("ContentVideoComplete", function(){
        webkit.messageHandlers.onContentVideoComplete.postMessage("");
    });
    
    p.on("ContentVideoEnded", function(){
        webkit.messageHandlers.onContentVideoEnded.postMessage("");
    });
    
    p.on("FullScreenRequest", function(){
        webkit.messageHandlers.onFullScreenRequest.postMessage("")
    });

    p.on("ContentFullScreenRequest", function(){
        webkit.messageHandlers.onContentFullScreenRequest.postMessage("")
    });
    
    if (sdkOptions.contentTimeTracking) {
        p.on("ContentTimeChange", function(event, data) {
            const message = { "position": data.currentTime, "duration": player.getContentDuration() }
            webkit.messageHandlers.onContentTimeChange.postMessage(message);
        });
    }
    
    p.on("ContentError", function(err) {
        Bridge.debugLog(JSON.stringify(err, null, 2));
        webkit.messageHandlers.onContentError.postMessage(JSON.stringify(err));
    });
    
    p.on("ContentClick", function() {
        webkit.messageHandlers.onContentClick.postMessage("");
    });
    
    p.on("AdEvent", function(event){
        Bridge.debugLog("AdEvent: " + event);
    });

    p.on("ContentCanPlay", function() {
        Bridge.debugLog("ContentLoaded ContentCanPlay");
        webkit.messageHandlers.onContentLoaded.postMessage("");
    });

    p.on("ContentLoadedMetadata", function() {
        Bridge.debugLog("ContentLoaded ContentLoadedMetadata");
        webkit.messageHandlers.onContentLoaded.postMessage("");
    });

    webkit.messageHandlers.onAvSdkApiReady.postMessage("");
    Bridge.debugLog("preparePlayer: finished");
}

renderer.prepareConfig = function(c) {
    c.floating = undefined;
    c.caption = {};
    c.adLabel = {};
    c.sticky = undefined;

    Object.assign(c, sdkConfig);
    // 'outstream' has no 'content'. 
    c.content = sdkOptions.isOutstream ? {} : c.content;
    Object.assign(c.content, contentOverride);

    Bridge.debugLog(JSON.stringify(c, null, 2));
    Bridge.debugLog("Prepare config finished");
}
