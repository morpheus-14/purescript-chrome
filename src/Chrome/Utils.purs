module Chrome.Utils where

import Prelude

import Control.Monad.Eff (Eff, kind Effect)
import Data.Time.Duration (Milliseconds(..))

foreign import data TIME :: Effect 

foreign import _now :: forall eff. Eff (time :: TIME | eff) Number

now :: forall eff. Eff (time :: TIME | eff) Milliseconds
now = Milliseconds <$> _now