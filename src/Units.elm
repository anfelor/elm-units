module Units exposing (..)



{-| 

Create Values of a certain unit, that abstract over a base.

# Types
@docs Value, Unit

# Constructor, conversions and "destructor"
@docs (~), as', toBase

# Working with the base
@docs map, map2, map3, map4, map5, map6
    , onBase, onBase2, onBase3, onBase4, onBase5, onBase6

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
as' : Value u1 v1 b -> Unit u2 v2 b -> Value u2 v2 b
as' value unit =
  { value = unit.wrap <| value.unit.unwrap value.value
  , unit = unit
  }


{-| Extract the base unit of a Value

  (90 ~ minutes) |> toBase
-}
toBase : Value u v b -> b
toBase value = value.unit.unwrap value.value


{-| Map over the base of a Value. 
-}
map
   : (b -> b) 
  -> Value u1 v1 b
  -> Value u1 v1 b
map fn v1 =
  { value = v1.unit.wrap <| fn (v1.unit.unwrap (v1.value))
  , unit = v1.unit
  }


{-| Map over the bases of Values
The resulting Value has the Unit of the first argument.
This is so make partial application more convenient:
`map2 fn v1` always has the unit of v1, no matter what you apply to it.
-}
map2 
   : (b -> b -> b) 
  -> Value u1 v1 b 
  -> Value u2 v2 b 
  -> Value u1 v1 b
map2 fn v1 v2 =
  { value = v1.unit.wrap <| fn (v1.unit.unwrap (v1.value)) 
                               (v2.unit.unwrap (v2.value))
  , unit = v1.unit
  }


{-|-}
map3
   : (b -> b -> b -> b) 
  -> Value u1 v1 b 
  -> Value u2 v2 b 
  -> Value u3 v3 b 
  -> Value u1 v1 b
map3 fn v1 v2 v3 =
  { value = v1.unit.wrap <| fn (v1.unit.unwrap (v1.value))
                               (v2.unit.unwrap (v2.value))
                               (v3.unit.unwrap (v3.value))
  , unit = v1.unit
  }


{-|-}
map4 
   : (b -> b -> b -> b -> b) 
  -> Value u1 v1 b 
  -> Value u2 v2 b 
  -> Value u3 v3 b 
  -> Value u4 v4 b
  -> Value u1 v1 b
map4 fn v1 v2 v3 v4 =
  { value = v1.unit.wrap <| fn (v1.unit.unwrap (v1.value))
                               (v2.unit.unwrap (v2.value))
                               (v3.unit.unwrap (v3.value))
                               (v4.unit.unwrap (v4.value))
  , unit = v1.unit
  }


{-|-}
map5 
   : (b -> b -> b -> b -> b -> b) 
  -> Value u1 v1 b 
  -> Value u2 v2 b
  -> Value u3 v3 b
  -> Value u4 v4 b
  -> Value u5 v5 b
  -> Value u1 v1 b
map5 fn v1 v2 v3 v4 v5 =
  { value = v1.unit.wrap <| fn (v1.unit.unwrap (v1.value))
                               (v2.unit.unwrap (v2.value))
                               (v3.unit.unwrap (v3.value))
                               (v4.unit.unwrap (v4.value))
                               (v5.unit.unwrap (v5.value))
  , unit = v1.unit
  }


{-|-}
map6 
   : (b -> b -> b -> b -> b -> b -> b) 
  -> Value u1 v1 b 
  -> Value u2 v2 b
  -> Value u3 v3 b
  -> Value u4 v4 b
  -> Value u5 v5 b
  -> Value u6 v6 b
  -> Value u1 v1 b
map6 fn v1 v2 v3 v4 v5 v6 =
  { value = v1.unit.wrap <| fn (v1.unit.unwrap (v1.value)) 
                               (v2.unit.unwrap (v2.value))
                               (v3.unit.unwrap (v3.value))
                               (v4.unit.unwrap (v4.value))
                               (v5.unit.unwrap (v5.value))
                               (v6.unit.unwrap (v6.value))
  , unit = v1.unit
  }



{-| Apply a function to the base of a value.
-}
onBase 
   : (b -> c)
  -> Value u1 v1 b
  -> c
onBase fn v1 =
  fn (toBase v1)


{-| Apply a function to the bases of two values.
-}
onBase2 
   : (b -> b -> c)
  -> Value u1 v1 b
  -> Value u2 v2 b
  -> c
onBase2 fn v1 v2 =
  fn (toBase v1)
     (toBase v2)


{-|-}
onBase3 
   : (b -> b -> b -> c)
  -> Value u1 v1 b
  -> Value u2 v2 b
  -> Value u3 v3 b
  -> c
onBase3 fn v1 v2 v3 =
  fn (toBase v1)
     (toBase v2)
     (toBase v3)


{-|-}
onBase4 
   : (b -> b -> b -> b -> c)
  -> Value u1 v1 b
  -> Value u2 v2 b
  -> Value u3 v3 b
  -> Value u4 v4 b
  -> c
onBase4 fn v1 v2 v3 v4 =
  fn (toBase v1)
     (toBase v2)
     (toBase v3)
     (toBase v4)


{-|-}
onBase5 
   : (b -> b -> b -> b -> b -> c)
  -> Value u1 v1 b
  -> Value u2 v2 b
  -> Value u3 v3 b
  -> Value u4 v4 b
  -> Value u5 v5 b
  -> c
onBase5 fn v1 v2 v3 v4 v5 =
  fn (toBase v1)
     (toBase v2)
     (toBase v3)
     (toBase v4)
     (toBase v5)


{-|-}
onBase6 
   : (b -> b -> b -> b -> b -> b -> c)
  -> Value u1 v1 b
  -> Value u2 v2 b
  -> Value u3 v3 b
  -> Value u4 v4 b
  -> Value u5 v5 b
  -> Value u6 v6 b
  -> c
onBase6 fn v1 v2 v3 v4 v5 v6 =
  fn (toBase v1)
     (toBase v2)
     (toBase v3)
     (toBase v4)
     (toBase v5)
     (toBase v6)