module LargestSeriesProduct exposing (largestProduct)
import List exposing (map, maximum, product)
import String exposing (dropLeft, left, toList, uncons)

all : (Char -> Bool) -> String -> Bool
all predicate string = case uncons string of
    Nothing -> True
    Just(c, xs) -> predicate c && all predicate xs
            
toInt : Char -> Int
toInt c = Char.toCode c - (Char.toCode '0')

charSequences : Int -> String -> List String
charSequences length series = 
    if String.length series < length then []
    else
        let tail = charSequences length (dropLeft 1 series)
        in left length series :: tail

largestProduct : Int -> String -> Maybe Int
largestProduct length series =
    if length > 0 && all Char.isDigit series then
        charSequences length series
            |> map (toList >> (map toInt) >> product) 
            |> maximum
    else
        Nothing
