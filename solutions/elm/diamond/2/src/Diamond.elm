module Diamond exposing (rows)

import List exposing (map, range, repeat, reverse)

toLetter : Int -> Char
toLetter n = n + (Char.toCode 'A') |> Char.fromCode

toOffset : Char -> Int
toOffset letter = (Char.toCode letter) - (Char.toCode 'A')

rowChars : Int -> Int -> List Char
rowChars halfSize offset =
    let
        innerPadding = repeat (offset * 2 - 1) '_'
        outerPadding = repeat (halfSize - offset) '_'
    in
        case toLetter offset of 
            'A' -> outerPadding ++ ['A'] ++ outerPadding
            l -> outerPadding ++ [l] ++ innerPadding ++ [l] ++ outerPadding

rowStrings : Int -> List String
rowStrings halfSize =  
    let
        head = range 0 (halfSize - 1)
        offsets = head ++ [halfSize] ++ (reverse head)
    in
        map (\o -> rowChars halfSize o |> String.fromList) offsets

rows : Char -> String
rows letter = 
    toOffset letter |> rowStrings |> String.join "\n"