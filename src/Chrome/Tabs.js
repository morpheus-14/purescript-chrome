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

exports._query = function(query) {
    return function (onError, onSuccess) {
        if (typeof chrome.tabs.query == "function") {
            var queryObj = {}
            var queryProps = query.map(function(prop) {
                return camelCase(prop.__proto__.constructor.name)
            })
            queryProps.forEach(function(key, index) {
                queryObj[key] = query[index].value0
            })
            chrome.tabs.query (queryObj, function (tabItems) {
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

function camelCase (val) {
    return val[0].toLowerCase() + val.slice(1);
}