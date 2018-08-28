# purescript-chrome

Purescript bindings for the [Chrome extenstion APIs](https://developer.chrome.com/extensions/devguide).

## Currently Supported Methods

- [**Tabs**](https://developer.chrome.com/extensions/tabs)
    - chrome.tabs.get
    - chrome.tabs.getCurrent
    - chrome.tabs.getAllInWindow
    - chrome.tabs.query
- [**History**](https://developer.chrome.com/extensions/history)
    - chrome.history.search
    - chrome.history.getVisits
    - chrome.history.addUrl
    - chrome.history.deleteUrl
    - chrome.hisotry.deleteAll

## Upcoming Support

- Events
- Perminssion, Manifest and Version compile-time checks
- [**Runtime**](https://developer.chrome.com/extensions/runtime)
- [**Storage**](https://developer.chrome.com/extensions/storage)
- [**Management**](https://developer.chrome.com/extensions/management)
- [**Commands**](https://developer.chrome.com/extensions/commands)

# Quick Start

This logs the 1st tab in the current window, if it exists.

```purescript
module Main where

import Prelude
import Chrome.Tabs (getTab)
import Effect.Aff (launchAff_)

main :: Effect Unit
main = launchAff_ do
    currentTab <- getTab 1
    case currentTab of
        Just tab -> liftEffect $ log tab.url
        Nothing -> pure unit
```

> Runs when extension is clicked and default popup opens.
> Log will be visible on inspecting the popup element