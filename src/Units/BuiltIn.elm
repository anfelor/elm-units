module BuiltIn exposing 
  ( BoolUnit, Bool', bool
  , IntUnit, Int', int)



{-| Unit definitions for built in types,
to allow for easy conversions between these.

# Booleans
@docs BoolUnit, Bool', bool

# Ints
@docs IntUnit, Int', int

-}


import Units exposing (..)


type BuiltIn 
  = BuiltIn


{-|-}
type alias BoolUnit =
  Unit BuiltIn Bool Int


{-| Mind the prime(')!
Uses ints internally (but use `toBase` for extracting!)
-}
type alias Bool' =
  { value : Bool
  , unit : BoolUnit
  }


{-| Map the base (ints) to bools.
  True -> 1
  False -> 0
  i < 1 -> False
  i > 0 -> True
-}
bool : BoolUnit
bool =
  { unit = BuiltIn 
  , wrap = \i -> if i > 0 then True else False
  , unwrap = \b -> if b then 1 else 0
  }


{-|-}
type alias IntUnit =
  Unit BuiltIn Int Int


{-| Mind the prime(')!
Uses ints internally (but use `toBase` for extracting!)
-}
type alias Int' =
  { value : Int
  , unit : IntUnit
  }


{-| Maps ints to ints.
No surprises here.
-}
int : IntUnit
int =
  { unit = BuiltIn 
  , wrap = identity
  , unwrap = identity
  }