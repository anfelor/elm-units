module Units.Angle exposing 
  (Angle, AngleUnit, degrees, radians)

import Units exposing (..)

type AngleUnitInternal
  = Degrees
  | Radians

type alias AngleUnit
  = Unit AngleUnitInternal Float Float

type alias Angle =
  { value : Float
  , unit : AngleUnit
  }

degrees : AngleUnit
degrees =
  { unit = Degrees
  , wrap = \d -> d / pi * 180
  , unwrap = \d -> d * pi / 180
  }

radians : AngleUnit
radians =
  { unit = Radians
  , wrap = identity
  , unwrap = identity
  }