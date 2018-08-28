exports._search = function(query) {
    return function (onError, onSuccess) {
        if (typeof chrome.history.search == "function") {
            chrome.history.search(query, function (historyItems) {
                onSuccess(historyItems)
            })
        } else {
            onError("function doesn't exist")
        }
        return function (cancelError, cancelerError, cancelerSuccess) {
            cancelerSuccess()
        }
    }
}

exports._visits = function(url) {
    return function (onError, onSuccess) {
        if (typeof chrome.history.getVisits == "function") {
            chrome.history.getVisits({url: url}, function (visitItems) {
                onSuccess(visitItems)
            })
        } else {
            onError("function doesn't exist")
        }
        return function (cancelError, cancelerError, cancelerSuccess) {
            cancelerSuccess()
        }
    }
}

exports._addUrl = function(url) {
    return function (onError, onSuccess) {
        if (typeof chrome.history.addUrl == "function") {
            chrome.history.addUrl({url: url}, function () {
                onSuccess()
            })
        } else {
            onError("function doesn't exist")
        }
        return function (cancelError, cancelerError, cancelerSuccess) {
            cancelerSuccess()
        }
    }
}

exports._deleteUrl = function(url) {
    return function (onError, onSuccess) {
        if (typeof chrome.history.deleteUrl == "function") {
            chrome.history.deleteUrl({url: url}, function () {
                onSuccess()
            })
        } else {
            onError("function doesn't exist")
        }
        return function (cancelError, cancelerError, cancelerSuccess) {
            cancelerSuccess()
        }
    }
}

exports._deleteRange = function(startTime) {
    return function(endTime) {
        return function (onError, onSuccess) {
            var query = {
                startTime: startTime,
                endTime: endTime
            }
            if (typeof chrome.history.deleteRange == "function") {
                chrome.history.deleteRange({ url: url }, function () {
                    onSuccess()
                })
            } else {
                onError("function doesn't exist")
            }
            return function (cancelError, cancelerError, cancelerSuccess) {
                cancelerSuccess()
            }
        }
    }
}

exports._deleteAll = function (onError, onSuccess) {
    if (typeof chrome.history.deleteAll == "function") {
        chrome.history.deleteAll(function () {
            onSuccess()
        })
    } else {
        onError("function doesn't exist")
    }
    return function (cancelError, cancelerError, cancelerSuccess) {
        cancelerSuccess()
    }
}