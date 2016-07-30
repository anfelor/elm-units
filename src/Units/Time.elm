module Units.Time exposing 
  (Time, TimeUnit, milliseconds, seconds, minutes, hours
  , millisecond, second, minute, hour, every)



{-| Unit definitions for Time.

@docs Time, TimeUnit, every

# Unit definition
Not related to [the "units" in the Time module](http://package.elm-lang.org/packages/elm-lang/core/4.0.3/Time#units)
@docs milliseconds, seconds, minutes, hours

# Specific times
These *are* the correspondents of [the "units" in the Time module](http://package.elm-lang.org/packages/elm-lang/core/4.0.3/Time#units)
@docs millisecond, second, minute, hour


-}


import Units exposing (..)
import Time



type TimeUnitInternal
  = Milliseconds
  | Seconds
  | Minutes
  | Hours


{-| The unit of time.
-}
type alias TimeUnit
  = Unit TimeUnitInternal Float Float


{-| A Value for time.
Uses milliseconds internally (but use `toBase` for extracting!)
-}
type alias Time =
  { value : Float
  , unit : TimeUnit
  }


{-|-}
milliseconds : TimeUnit
milliseconds =
  { unit = Milliseconds 
  , wrap = identity
  , unwrap = identity
  }


{-|-}
seconds : TimeUnit
seconds =
  { unit = Seconds 
  , wrap = \v -> v / 1000
  , unwrap = \v -> v * 1000
  }


{-|-}
minutes : TimeUnit
minutes =
  { unit = Minutes
  , wrap = \v -> v / 1000 / 60
  , unwrap = \v -> v * 1000 * 60
  }


{-|-}
hours : TimeUnit
hours =
  { unit = Hours
  , wrap = \v -> v / 1000 / 60 / 60
  , unwrap = \v -> v / 1000 * 60 * 60
  }


{-|
  every millisecond Tick
-}
millisecond : Time
millisecond =
  1.0 ~ milliseconds


{-|-}
second : Time
second =
  1.0 ~ seconds


{-|-}
minute : Time
minute =
  1.0 ~ minutes


{-|-}
hour : Time
hour =
 1.0 ~ hours


{-|-}
every : Time -> (Time.Time -> msg) -> Sub msg
every time tagger =
  Time.every (toBase <| time `as'` milliseconds) tagger