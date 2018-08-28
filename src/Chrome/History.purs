module Chrome.History where
  
import Chrome.Core
import Chrome.Types
import Data.Time.Duration
import Prelude

import Chrome.Utils (now)
import Effect.Aff (Aff, Milliseconds(..))
import Effect.Aff.Compat (EffectFnAff(..), fromEffectFnAff)
import Effect (Effect)
import Effect.Class (liftEffect)

type HistoryQuery = { text :: String
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

defaultQuery :: String -> Effect HistoryQuery
defaultQuery text = now >>= \endTime -> pure { text : text
                                             , startTime : Milliseconds 0.0
                                             , endTime : endTime
                                             , maxResults : 100
                                             }

foreign import _search :: HistoryQuery -> EffectFnAff (Array HistoryItem)
foreign import _visits :: URL -> EffectFnAff (Array VisitItem)
foreign import _addUrl :: URL -> EffectFnAff Unit
foreign import _deleteUrl :: URL -> EffectFnAff Unit
foreign import _deleteRange :: Number -> Number -> EffectFnAff Unit
foreign import _deleteAll :: EffectFnAff Unit

search :: HistoryQuery -> Aff (Array HistoryItem)
search = fromEffectFnAff <<< _search

searchText :: String -> Aff (Array HistoryItem)
searchText str = liftEffect (defaultQuery str) >>= search

visits :: URL -> Aff (Array VisitItem)
visits = fromEffectFnAff <<< _visits

add :: URL -> Aff Unit
add = fromEffectFnAff <<< _addUrl

delete :: URL -> Aff Unit
delete = fromEffectFnAff <<< _deleteUrl

deleteRange :: Milliseconds -> Milliseconds -> Aff Unit
deleteRange (Milliseconds start) (Milliseconds end) = fromEffectFnAff $ _deleteRange start end

deleteAll :: Aff Unit
deleteAll = fromEffectFnAff _deleteAll