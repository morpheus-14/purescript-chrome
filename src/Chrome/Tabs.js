
exports._get = function(just, nothing, tabId) {
    return function (onError, onSuccess) {
        if (typeof chrome.tabs.get == "function") {
            chrome.tabs.get(tabId, function (tabItem) {
                if (tabItem){
                    onSuccess(just(tabItem))
                } else {
                    onSuccess(nothing)
                }
            })
        } else {
            onError("function doesn't exist")
        }
        return function (cancelError, cancelerError, cancelerSuccess) {
            cancelerSuccess()
        }
    }
}

exports._getCurrent = function (just, nothing) {
    return function (onError, onSuccess) {
        if (typeof chrome.tabs.getCurrent == "function") {
            chrome.tabs.getCurrent(function (tabItem) {
                if (tabItem) {
                    onSuccess(just(tabItem))
                } else {
                    onSuccess(nothing)
                }
            })
        } else {
            onError("function doesn't exist")
        }
        return function (cancelError, cancelerError, cancelerSuccess) {
            cancelerSuccess()
        }
    }
}

exports._getAllInWindow = function(windowId) {
    return function (onError, onSuccess) {
        if (typeof chrome.tabs.getAllInWindow == "function") {
            chrome.tabs.getAllInWindow(windowId, function (tabItems) {
                onSuccess(tabItems)
            })
        } else {
            onError("function doesn't exist")
        }
        return function (cancelError, cancelerError, cancelerSuccess) {
            cancelerSuccess()
        }
    }
}