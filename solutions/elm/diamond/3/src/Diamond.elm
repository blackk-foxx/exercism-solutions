module Diamond exposing (rows)

import List exposing (map, range, repeat, reverse)

toLetter : Int -> Char
toLetter n = n + (Char.toCode 'A') |> Char.fromCode

toOffset : Char -> Int
toOffset letter = (Char.toCode letter) - (Char.toCode 'A')

rowChars : Int -> Int -> List Char
rowChars endOffset rowOffset =
    let
        innerSpaceCount = rowOffset * 2 - 1
        innerPadding = repeat innerSpaceCount '_'
        outerPadding = repeat (endOffset - rowOffset) '_'
        innerContent = case toLetter rowOffset of
            'A' -> ['A']
            l -> [l] ++ innerPadding ++ [l]
    in
        outerPadding ++ innerContent ++ outerPadding

rowStrings : Int -> List String
rowStrings endOffset =  
    let
        ascendingSequence = range 0 (endOffset - 1)
        offsets = ascendingSequence ++ [endOffset] ++ (reverse ascendingSequence)
    in
        offsets |> map (rowChars endOffset >> String.fromList)

rows : Char -> String
rows = toOffset >> rowStrings >> String.join "\n"