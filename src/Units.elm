module Units exposing (..)



{-| 

Create Values of a certain unit, that abstract over a base.

# Types
@docs Value, Unit

# Constructor, conversions and "destructor"
@docs (~), as', fromBase, toBase

# Working with the base
@docs lift, lift2, lift3, lift4, lift5, lift6

-}


{-| Unit declarations.
These should be hidden in your library,
be sure not to export construct of your unit type.
   unit         The unit type
   value        The value to be stored and used in the (~) constructor
   base         The base value all your Units can be converted to.
-}
type alias Unit unit value base =
  { unit : unit
  , wrap : base -> value
  , unwrap : value -> base
  }


{-| Values passed around in your program.
unit, value and base like above.
-}
type alias Value unit value base =
  { value : value
  , unit : Unit unit value base
  }


{-| Given some value v and a Unit construct a Value.
What v means in terms of base, is defined by the Unit.
Its precedence is 5, higher than (==) and lower than (+), (*)

  (3 * 30 ~ minutes)
-}
(~) : v -> Unit u v b -> Value u v b
(~) value unit =
  { value = value
  , unit = unit
  }

infix 5 ~


{-| Convert a Value to a different unit.

  (90 ~ minutes) `as'` seconds
-}
as' : Value u v1 b -> Unit u v2 b -> Value u v2 b
as' value unit =
  { value = unit.wrap <| value.unit.unwrap value.value
  , unit = unit
  }


{-| Extract the base unit of a Value

  (90 ~ minutes) |> toBase
-}
toBase : Value u v b -> b
toBase value = value.unit.unwrap value.value


{-| Create a Value from a base.

  fromBase seconds 123 : TimeUnit
-}
fromBase : Unit u v b -> b -> Value u v b
fromBase unit base =
  { value = unit.wrap base
  , unit = unit
  }


{-| Apply a function to the base of a value.
-}
lift 
   : (b -> c)
  -> Value u v1 b
  -> c
lift fn v1 =
  fn (toBase v1)


{-| Apply a function to the bases of two values.
-}
lift2 
   : (b -> b -> c)
  -> Value u v1 b
  -> Value u v2 b
  -> c
lift2 fn v1 v2 =
  fn (toBase v1)
     (toBase v2)


{-|-}
lift3 
   : (b -> b -> b -> c)
  -> Value u v1 b
  -> Value u v2 b
  -> Value u v3 b
  -> c
lift3 fn v1 v2 v3 =
  fn (toBase v1)
     (toBase v2)
     (toBase v3)


{-|-}
lift4 
   : (b -> b -> b -> b -> c)
  -> Value u v1 b
  -> Value u v2 b
  -> Value u v3 b
  -> Value u v4 b
  -> c
lift4 fn v1 v2 v3 v4 =
  fn (toBase v1)
     (toBase v2)
     (toBase v3)
     (toBase v4)


{-|-}
lift5 
   : (b -> b -> b -> b -> b -> c)
  -> Value u v1 b
  -> Value u v2 b
  -> Value u v3 b
  -> Value u v4 b
  -> Value u v5 b
  -> c
lift5 fn v1 v2 v3 v4 v5 =
  fn (toBase v1)
     (toBase v2)
     (toBase v3)
     (toBase v4)
     (toBase v5)


{-|-}
lift6 
   : (b -> b -> b -> b -> b -> b -> c)
  -> Value u v1 b
  -> Value u v2 b
  -> Value u v3 b
  -> Value u v4 b
  -> Value u v5 b
  -> Value u v6 b
  -> c
lift6 fn v1 v2 v3 v4 v5 v6 =
  fn (toBase v1)
     (toBase v2)
     (toBase v3)
     (toBase v4)
     (toBase v5)
     (toBase v6)