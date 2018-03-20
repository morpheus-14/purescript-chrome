module Chrome.Tabs where
  
import Prelude

import Chrome.Core (CHROME)
import Chrome.Types (URL)
import Control.Monad.Aff (Aff)
import Control.Monad.Aff.Compat (EffFnAff, fromEffFnAff)
import Data.Function.Uncurried (Fn2, Fn3, runFn2, runFn3)
import Data.Maybe (Maybe(..))
  
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
foreign import _getAllInWindow :: forall eff. Int -> EffFnAff (chrome :: CHROME | eff) (Array Tab)

get :: forall eff. Int -> Aff (chrome :: CHROME | eff) (Maybe Tab)
get = fromEffFnAff <<< runFn3 _get Just Nothing

getCurrent :: forall eff. Aff (chrome :: CHROME | eff) (Maybe Tab)
getCurrent = fromEffFnAff $ runFn2 _getCurrent Just Nothing

getAllInWindow :: forall eff. Int -> Aff (chrome :: CHROME | eff) (Array Tab)
getAllInWindow = fromEffFnAff <<< _getAllInWindow