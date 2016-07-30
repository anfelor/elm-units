# Unit conversions for elm

This library enables you to convert between units seamlessly.
```elm
import Units exposing (..)
import Units.Time as Time

sub = Time.every (23 * 42 ~ seconds) Tick
```
```elm
(90 ~ degrees) `as'` radians
```