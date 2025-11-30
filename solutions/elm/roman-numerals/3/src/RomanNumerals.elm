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
toRomanFromList index number =
    case Array.get index valueWithRomanLiteral of
        Just (value, literal) ->
            if number >= value then 
                literal ++ (toRomanFromList index (number - value))
            else
                toRomanFromList (index - 1) number
        Nothing -> ""
