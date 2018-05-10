module Chrome.Core where
  
import Prelude

import Control.Monad.Eff (kind Effect)

foreign import data CHROME :: Effect

-- Need to support following list of browsers (in order of priority)
-- Chrome / Chromium -> https://developer.chrome.com/extensions/devguide, https://www.chromium.org/developers/design-documents/extensions
-- Firefox -> https://developer.mozilla.org/en-US/Add-ons/WebExtensions/Browser_support_for_JavaScript_APIs
-- Opera -> https://dev.opera.com/extensions/apis/
-- Edge (Covered by chrome mostly) -> https://docs.microsoft.com/en-us/microsoft-edge/extensions/api-support/supported-apis
-- Brave 
-- Safari -> https://developer.apple.com/library/content/documentation/Tools/Conceptual/SafariExtensionGuide/Introduction/Introduction.html
-- Vivaldi (Covered by chrome mostly)