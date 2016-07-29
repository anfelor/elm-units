module AngleTest exposing (main)

import ElmTest exposing (..)

import Units exposing (..)
import Units.Angle as Angle

angle : Test
angle =
  suite "Angle conversions"
    [ test "360 degrees == 2π radians"
        (assertEqual (2*pi ::: Angle.radians |> toBase) (360 ::: Angle.degrees |> toBase) )
    , test "0.5π radians == 90 degrees"
        (assertEqual (0.5*pi ::: Angle.radians |> toBase) (90 ::: Angle.degrees |> toBase))
    ]

main : Program Never
main = ElmTest.runSuite angle