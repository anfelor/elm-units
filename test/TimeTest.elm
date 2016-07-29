module TimeTest exposing (main)

import ElmTest
import Check exposing (..)
import Check.Producer exposing (..)
import Check.Test

import Array
import Maybe

import Units exposing (..)
import Units.Time exposing (..)

units : Producer (Unit TimeUnit Float Float)
units = map (
          \i -> Array.fromList [milliseconds, seconds, minutes, hours]
             |> Array.get i
             |> Maybe.withDefault milliseconds
          ) (rangeInt 0 3)

time : Claim
time =
  suite "Converting to base and back"
    [ claim
        "Convert to base and back == identity"
      `that`
        (\(f, u) -> f ::: milliseconds |> toBase)
      `is`
        fst
      `for`
        tuple (float, units)
    ]

evidence : Evidence
evidence = quickCheck time

main : Program Never
main = ElmTest.runSuite (Check.Test.evidenceToTest evidence)