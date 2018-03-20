module Chrome.Tabs where
  
import Prelude

import Chrome.Core (CHROME)
import Chrome.Types (URL)
import Control.Monad.Aff (Aff)
import Control.Monad.Aff.Compat (EffFnAff, fromEffFnAff)
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

foreign import _get :: forall a eff. Fn3 (a -> Maybe a) (Maybe a) Int (EffFnAff (chrome :: CHROME | eff) (Maybe Tab))
foreign import _getCurrent :: forall a eff. Fn2 (a -> Maybe a) (Maybe a) (EffFnAff (chrome :: CHROME | eff) (Maybe Tab))
foreign import _query :: forall eff. TabQuery -> EffFnAff (chrome :: CHROME | eff) (Array Tab)

get :: forall eff. Int -> Aff (chrome :: CHROME | eff) (Maybe Tab)
get = fromEffFnAff <<< runFn3 _get Just Nothing

getCurrent :: forall eff. Aff (chrome :: CHROME | eff) (Maybe Tab)
getCurrent = fromEffFnAff $ runFn2 _getCurrent Just Nothing

query :: forall eff. TabQuery -> Aff (chrome :: CHROME | eff) (Array Tab)
query = fromEffFnAff <<< _query

getAllInWindow :: forall eff. Int -> Aff (chrome :: CHROME | eff) (Array Tab)
getAllInWindow id = query $ singleton $ WindowId id

getActive :: forall eff. Boolean -> Aff (chrome :: CHROME | eff) (Array Tab)
getActive act = query $ singleton $ Active act

getWithIndex :: forall eff. Int -> Aff (chrome :: CHROME | eff) (Maybe Tab)
getWithIndex ind = head <$> (query $ singleton $ Index ind)

getWithUrl :: forall eff. URL -> Aff (chrome :: CHROME | eff) (Array Tab)
getWithUrl url = query $ singleton $ Url url

getAllInCurrentWindow :: forall eff. Aff (chrome:: CHROME | eff) (Array Tab)
getAllInCurrentWindow = query $ singleton $ CurrentWindow true