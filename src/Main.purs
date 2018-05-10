module Main where

import Prelude

import Chrome.Core (CHROME)
import Chrome.History (search, searchText)
import Chrome.Tabs (get, getAllInWindow, getCurrent, getWithIndex, getAllInCurrentWindow, runMyQuery)
import Chrome.Utils (TIME, now)
import Control.Applicative (pure)
import Control.Monad.Aff (Aff, launchAff_, liftEff', runAff)
import Control.Monad.Aff.Console (CONSOLE, log, logShow)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Data.Array (head, unsafeIndex)
import Data.Maybe (fromJust, fromMaybe)
import Partial.Unsafe (unsafePartial)

main :: forall e. Eff (console :: CONSOLE, chrome :: CHROME, time :: TIME | e) Unit
main = launchAff_ do
  -- search "" (\x -> log $ fromMaybe "hello" $ head ((\h -> h.url) <$> x))
  liftEff now >>= logShow
  -- history <- searchText ""
  -- log $ fromMaybe "heyyylo" (head ((\h -> h.url) <$> history))
  testTabs <- runMyQuery { windowId : 1 }
  allTabs <- getAllInWindow 1
  myTab <- getWithIndex 10
  allCurrentTabs <- getAllInCurrentWindow
  log (unsafePartial $ (unsafeIndex testTabs 3).url)
  log (unsafePartial $ (fromJust myTab).url)
  pure unit