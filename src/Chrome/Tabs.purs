module Chrome.Tabs where
  
import Prelude

import Chrome.Types (URL)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Data.Array (head, singleton, (:))
import Data.Function.Uncurried (Fn2, Fn3, runFn2, runFn3)
import Data.Maybe (Maybe(..))
  

data TabOptions = Active Boolean 
                | Pinned Boolean 
                | Audible Boolean
                | Muted Boolean
                | Highlighted Boolean
                | Discarded Boolean
                | AutoDiscardable Boolean
                | CurrentWindow Boolean
                | LastFocusedWindow Boolean
                | Title String
                | Url URL
                | Urls (Array URL)
                | WindowId Int
                | Index Int

type TabQuery = Array TabOptions

type Tab = { id :: Int
           , index :: Int
           , windowId :: Int
           , openerTabId :: Int
           , highlighted :: Boolean
           , active :: Boolean
           , pinned :: Boolean 
           , audible :: Boolean
           , discarded :: Boolean
           , autoDiscardable :: Boolean
           , url :: URL
           , title :: String
           , faviconUrl :: URL
           , status :: String
           , incognito :: Boolean
           , width :: Int
           , height :: Int
           , sessionId :: String
           }

foreign import _get :: forall a. Fn3 (a -> Maybe a) (Maybe a) Int (EffectFnAff (Maybe Tab))
foreign import _getCurrent :: forall a. Fn2 (a -> Maybe a) (Maybe a) (EffectFnAff (Maybe Tab))
foreign import _query :: TabQuery -> EffectFnAff (Array Tab)

getTab :: Int -> Aff (Maybe Tab)
getTab = fromEffectFnAff <<< runFn3 _get Just Nothing

getCurrentTab :: Aff (Maybe Tab)
getCurrentTab = fromEffectFnAff $ runFn2 _getCurrent Just Nothing

query :: TabQuery -> Aff (Array Tab)
query = fromEffectFnAff <<< _query

getAllInWindow :: Int -> Aff (Array Tab)
getAllInWindow id = query $ singleton $ WindowId id

getActive :: Boolean -> Aff (Array Tab)
getActive act = query $ singleton $ Active act

getWithIndex :: Int -> Aff (Maybe Tab)
getWithIndex ind = head <$> (query $ singleton $ Index ind)

getWithUrl :: URL -> Aff (Array Tab)
getWithUrl url = query $ singleton $ Url url

getAllInCurrentWindow :: Aff (Array Tab)
getAllInCurrentWindow = query $ singleton $ CurrentWindow true