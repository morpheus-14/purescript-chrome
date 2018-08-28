module Chrome.Utils where

import Prelude

import Effect (Effect)
import Data.Time.Duration (Milliseconds(..))

foreign import _now :: Effect Number

now :: Effect Milliseconds
now = Milliseconds <$> _now