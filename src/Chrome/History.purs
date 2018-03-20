module Chrome.History where
  
import Chrome.Core
import Chrome.Types
import Data.Time.Duration
import Prelude

import Chrome.Utils (TIME, now)
import Control.Monad.Aff (Aff, Milliseconds(..))
import Control.Monad.Aff.Compat (EffFnAff(..), fromEffFnAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)

type Query = { text :: String
             , startTime :: Milliseconds
             , endTime :: Milliseconds
             , maxResults :: Int
             }

type HistoryItem = { id :: String
                   , url :: URL
                   , title :: String
                   , lastVisitTime :: Milliseconds
                   , visitCount :: Int
                   , typedCount :: Int
                   }

type VisitItem = { id :: String
                 , visitId :: String
                 , visitTime :: Milliseconds
                 , referringVisitId :: String
                 , transitionType :: String
                 }

type RangeT = { statrtTime :: Milliseconds
              , endTime :: Milliseconds
              }

defaultQuery :: forall eff. String -> Eff (time :: TIME | eff) Query
defaultQuery text = now >>= \endTime -> pure { text : text
                                             , startTime : Milliseconds 0.0
                                             , endTime : endTime
                                             , maxResults : 100
                                             }

foreign import _search :: forall eff. Query -> EffFnAff (chrome :: CHROME | eff) (Array HistoryItem)
foreign import _visits :: forall eff. URL -> EffFnAff (chrome :: CHROME | eff) (Array VisitItem)
foreign import _addUrl :: forall eff. URL -> EffFnAff (chrome :: CHROME | eff) Unit
foreign import _deleteUrl :: forall eff. URL -> EffFnAff (chrome :: CHROME | eff) Unit
foreign import _deleteRange :: forall eff. Number -> Number -> EffFnAff (chrome :: CHROME | eff) Unit
foreign import _deleteAll :: forall eff. EffFnAff (chrome :: CHROME | eff) Unit

search :: forall eff. Query -> Aff (chrome :: CHROME , time :: TIME | eff) (Array HistoryItem)
search = fromEffFnAff <<< _search

searchText :: forall eff. String -> Aff (chrome :: CHROME , time :: TIME | eff) (Array HistoryItem)
searchText str = liftEff (defaultQuery str) >>= search

visits :: forall eff. URL -> Aff (chrome :: CHROME | eff) (Array VisitItem)
visits = fromEffFnAff <<< _visits

add :: forall eff. URL -> Aff (chrome :: CHROME | eff) Unit
add = fromEffFnAff <<< _addUrl

delete :: forall eff. URL -> Aff (chrome :: CHROME | eff) Unit
delete = fromEffFnAff <<< _deleteUrl

deleteRange :: forall eff. Milliseconds -> Milliseconds -> Aff (chrome :: CHROME | eff) Unit
deleteRange (Milliseconds start) (Milliseconds end) = fromEffFnAff $ _deleteRange start end

deleteAll :: forall eff. Aff (chrome :: CHROME | eff) Unit
deleteAll = fromEffFnAff _deleteAll