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
            
        charSequences : Int -> String -> List String
        charSequences len str = 
            if String.length str < len then []
            else
                left len str :: charSequences len (dropLeft 1 str)

        intSequences : Int -> String -> List(List Int)
        intSequences len ser = charSequences len ser 
            |> map toList 
            |> map (map (\c -> Char.toCode c - 0x30)) 

    in
        if  length > 0 && allDigits series then
            intSequences length series |> map product |> maximum
        else
            Nothing
