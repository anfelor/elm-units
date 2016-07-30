module Units.Time exposing 
  (Time, TimeUnit, milliseconds, seconds, minutes, hours
  , millisecond, second, minute, hour, every)

import Units exposing (..)
import Time

type TimeUnitInternal
  = Milliseconds
  | Seconds
  | Minutes
  | Hours

type alias TimeUnit
  = Unit TimeUnitInternal Float Float

type alias Time =
  { value : Float
  , unit : TimeUnit
  }

milliseconds : TimeUnit
milliseconds =
  { unit = Milliseconds 
  , wrap = identity
  , unwrap = identity
  }

seconds : TimeUnit
seconds =
  { unit = Seconds 
  , wrap = \v -> v / 1000
  , unwrap = \v -> v * 1000
  }

minutes : TimeUnit
minutes =
  { unit = Minutes
  , wrap = \v -> v / 1000 / 60
  , unwrap = \v -> v * 1000 * 60
  }

hours : TimeUnit
hours =
  { unit = Hours
  , wrap = \v -> v / 1000 / 60 / 60
  , unwrap = \v -> v / 1000 * 60 * 60
  }

millisecond : Time
millisecond =
  1.0 ~ milliseconds

second : Time
second =
  1.0 ~ seconds

minute : Time
minute =
  1.0 ~ minutes

hour : Time
hour =
 1.0 ~ hours

every : Time -> (Time.Time -> msg) -> Sub msg
every time tagger =
  Time.every (toBase <| time `as'` milliseconds) tagger