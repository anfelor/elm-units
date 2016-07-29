module Units.Angle exposing 
  (Angle, degrees, radians)

import Units exposing (..)

type AngleUnit 
    = Degrees
    | Radians

type alias Angle =
  { value : Float
  , unit : Unit AngleUnit Float Float
  }

degrees : Unit AngleUnit Float Float
degrees =
  { unit = Degrees
  , wrap = \d -> d / pi * 180
  , unwrap = \d -> d * pi / 180
  }

radians : Unit AngleUnit Float Float
radians =
  { unit = Radians
  , wrap = identity
  , unwrap = identity
  }