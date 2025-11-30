module RomanNumerals exposing (toRoman)
import Array
 
valueWithRomanLiteral = Array.fromList [
        (1, "I"),
        (4, "IV"),
        (5, "V"),
        (9, "IX"),
        (10, "X"),
        (40, "XL"),
        (50, "L"),
        (90, "XC"),
        (100, "C"),
        (400, "CD"),
        (500, "D"),
        (900, "CM"),
        (1000, "M")
    ]

toRoman : Int -> String
toRoman number = toRomanFromList (Array.length valueWithRomanLiteral - 1) number

toRomanFromList : Int -> Int -> String
toRomanFromList index number = case number of
    0 -> ""
    n -> case index of
        0 -> "I" ++ toRomanFromList 0 (n - 1)
        i -> case Array.get i valueWithRomanLiteral of
            Just (value, literal) ->
                if number >= value then 
                    literal ++ (toRomanFromList i (number - value))
                else
                    toRomanFromList (i - 1) number
            Nothing -> ""
