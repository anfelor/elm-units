module Units.Angle exposing 
  (Angle, AngleUnit, degrees, radians)



{-| Unit definitions for angles.

@docs Angle, AngleUnit, degrees, radians

-}


import Units exposing (..)



type AngleUnitInternal
  = Degrees
  | Radians


{-| The unit of angles.
-}
type alias AngleUnit
  = Unit AngleUnitInternal Float Float


{-| A Value for angles.
Uses radians internally (but use `toBase` for extracting!)
-}
type alias Angle =
  { value : Float
  , unit : AngleUnit
  }


{-| Construct angles as degrees.

  (90 ~ degrees) : Angle
-}
degrees : AngleUnit
degrees =
  { unit = Degrees
  , wrap = \d -> d / pi * 180
  , unwrap = \d -> d * pi / 180
  }


{-| Construct angles as radians.

  (pi ~ radians) : Angle
-}
radians : AngleUnit
radians =
  { unit = Radians
  , wrap = identity
  , unwrap = identity
  }