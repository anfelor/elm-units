module Units.Time exposing 
  (Time, milliseconds, seconds, minutes, hours
  , millisecond, second, minute, hour, every)

import Units exposing (..)
import Time

type TimeUnit 
    = Milliseconds
    | Seconds
    | Minutes
    | Hours

type alias Time =
  { value : Float
  , unit : Unit TimeUnit Float Float
  }

milliseconds : Unit TimeUnit Float Float
milliseconds =
  { unit = Milliseconds 
  , wrap = identity
  , unwrap = identity
  }

seconds : Unit TimeUnit Float Float
seconds =
  { unit = Seconds 
  , wrap = \v -> v / 1000
  , unwrap = \v -> v * 1000
  }

minutes : Unit TimeUnit Float Float
minutes =
  { unit = Minutes
  , wrap = \v -> v / 1000 / 60
  , unwrap = \v -> v * 1000 * 60
  }

hours : Unit TimeUnit Float Float
hours =
  { unit = Hours
  , wrap = \v -> v / 1000 / 60 / 60
  , unwrap = \v -> v / 1000 * 60 * 60
  }

millisecond : Time
millisecond =
  1.0 ::: milliseconds

second : Time
second =
  1.0 ::: seconds

minute : Time
minute =
  1.0 ::: minutes

hour : Time
hour =
 1.0 ::: hours

every : Time -> (Time.Time -> msg) -> Sub msg
every time tagger =
  Time.every (toBase <| time `as'` milliseconds) tagger