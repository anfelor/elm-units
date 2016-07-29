module Units exposing (..)

type alias Unit unit value base =
  { unit : unit
  , wrap : base -> value
  , unwrap : value -> base
  }

type alias Value unit value base =
  { value : value
  , unit : Unit unit value base
  }

(:::) : v -> Unit u v b -> Value u v b
(:::) value unit =
  { value = value
  , unit = unit
  }

as' : Value u1 v1 b -> Unit u2 v2 b -> Value u2 v2 b
as' value unit =
  { value = unit.wrap <| value.unit.unwrap value.value
  , unit = unit
  }

toBase : Value u v b -> b
toBase value = value.unit.unwrap value.value