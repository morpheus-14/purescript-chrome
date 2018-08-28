module Main where

import Prelude

import Chrome.History (search, searchText)
import Chrome.Tabs (get, getAllInWindow, getCurrent, getWithIndex, getAllInCurrentWindow)
import Chrome.Utils (now)
import Control.Applicative (pure)
import Effect.Aff (Aff, launchAff_, runAff)
import Effect.Class (liftEffect)
import Effect (Effect)
import Effect.Class.Console
import Data.Array (head, unsafeIndex)
import Data.Maybe (fromJust, fromMaybe)
import Partial.Unsafe (unsafePartial)

main :: Effect Unit
main = launchAff_ do
  -- search "" (\x -> log $ fromMaybe "hello" $ head ((\h -> h.url) <$> x))
  liftEffect now >>= logShow
  -- history <- searchText ""
  -- log $ fromMaybe "heyyylo" (head ((\h -> h.url) <$> history))
  currTab <- get 2
  allTabs <- getAllInWindow 1
  myTab <- getWithIndex 10
  allCurrentTabs <- getAllInCurrentWindow
  liftEffect $ log (unsafePartial $ (fromJust currTab).url)
  liftEffect $ log (unsafePartial $ (unsafeIndex allCurrentTabs 10).url)
  liftEffect $ log (unsafePartial $ (fromJust myTab).url)
  pure unit