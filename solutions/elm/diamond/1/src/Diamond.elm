module Diamond exposing (rows)

import List exposing (drop, repeat, reverse)

row letter size position =
    let
        padSize = size - position
        leftPadding = repeat (size-padSize) '_'
        rightPadding = repeat padSize '_'
        rowTail = leftPadding ++ [letter] ++ rightPadding 
        rowHead = reverse (drop 1 rowTail)
    in rowHead ++ rowTail
            
toChar n = n + (Char.toCode 'A') |> Char.fromCode

toInt letter = (Char.toCode letter) - (Char.toCode 'A')

line size count = 
    let 
        position = size - count
        letter = toChar position
    in row letter size position |> String.fromList

pattern size count =  
    let patternLine = [line size count]
    in case count of
        0 -> patternLine
        n -> patternLine ++ pattern size (n-1) ++ patternLine

rows : Char -> String
rows letter = 
    let
        size = toInt letter
        lines = pattern size size
    in String.join "\n" lines