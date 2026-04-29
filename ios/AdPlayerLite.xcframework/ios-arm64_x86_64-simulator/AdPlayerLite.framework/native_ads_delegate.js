SDKDelegate = {
    initAd: function(contextId, type, payload) {
        var message = { contextId: contextId, type: type, payload: payload };
        webkit.messageHandlers.initAd.postMessage(message);
    },
    startAd: function(contextId) {
        webkit.messageHandlers.startAd.postMessage(contextId);
    },
    pauseAd: function(contextId) {
        webkit.messageHandlers.pauseAd.postMessage(contextId);
    },
    resumeAd: function(contextId) {
        webkit.messageHandlers.resumeAd.postMessage(contextId);
    },
    stopAd: function(contextId) {
        webkit.messageHandlers.stopAd.postMessage(contextId);
    },
    setAdVolume: function(contextId, payload) {
        webkit.messageHandlers.setAdVolume.postMessage(payload.volume);
    },
    getAdVolume: function(contextId) {
        var res = prompt("getAdVolume");
        return parseFloat(res);
    },
    getAdSkippableState: function(contextId) {
        return nativeAds.isSkippable;
    },
    getAdWidth: function(contextId) {
        var res = prompt("getAdWidth");
        return parseFloat(res);
    },
    getAdHeight: function(contextId) {
        var res = prompt("getAdHeight");
        return parseFloat(res);
    },
    getAdRemainingTime: function(contextId) {
        var res = prompt("getAdRemainingTime");
        return parseFloat(res);
    },
    getAdDuration: function(contextId) {
        return nativeAds.duration
    }
};
