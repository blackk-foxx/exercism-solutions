module Raindrops exposing (raindrops)


raindrops : Int -> String
raindrops number = 
    let
        result = 
            (if (modBy 3 number) == 0 then "Pling" else "") ++
            (if (modBy 5 number) == 0 then "Plang" else "") ++
            (if (modBy 7 number) == 0 then "Plong" else "")
        in
            if result == "" then String.fromInt number else result
