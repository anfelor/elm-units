module Units exposing (..)



{-| Unit declarations.
These should be hidden in your library,
be sure not to export construct of your unit type.
   unit         The unit type
   value        The value to be stored and used in the (:::) constructor
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
What v means in terms of base, is defined by the Unit
-}
(:::) : v -> Unit u v b -> Value u v b
(:::) value unit =
  { value = value
  , unit = unit
  }


{-| Convert a Value to a different unit.
-}
as' : Value u1 v1 b -> Unit u2 v2 b -> Value u2 v2 b
as' value unit =
  { value = unit.wrap <| value.unit.unwrap value.value
  , unit = unit
  }


{-| Extract the base unit of a Value
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