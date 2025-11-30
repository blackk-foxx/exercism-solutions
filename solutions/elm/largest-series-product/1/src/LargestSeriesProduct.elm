module LargestSeriesProduct exposing (largestProduct)
import List exposing (map, maximum, product)
import String exposing (dropLeft, left, toList, uncons)

largestProduct : Int -> String -> Maybe Int
largestProduct length series =
    let
        allDigits : String -> Bool
        allDigits str = case uncons str of
            Nothing -> True
            Just(c, xs) -> Char.isDigit c && allDigits xs
            
        charSequences : Int -> String -> List(String)
        charSequences len str = 
            let head = left len str
            in
                if String.length head == len then 
                    head :: charSequences len (dropLeft 1 str)
                else []

        charLists = map toList (charSequences length series)
        intSequences = map (map (\c -> Char.toCode c - 0x30)) charLists 

    in
        if allDigits series then
            maximum (map product intSequences)
        else
            Nothing
