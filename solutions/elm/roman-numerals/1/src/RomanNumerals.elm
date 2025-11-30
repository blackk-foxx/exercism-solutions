module RomanNumerals exposing (toRoman)

toRoman : Int -> String
toRoman number = case number of
    0 -> ""
    1 -> "I"
    n ->
        if n < 4 then "I" ++ (toRoman (n - 1))
        else if n < 5 then "IV" ++ (toRoman (n - 4))
        else if n < 9 then "V" ++ (toRoman (n - 5))
        else if n < 10 then "IX" ++ (toRoman (n - 9))
        else if n < 40 then "X" ++ (toRoman (n - 10))
        else if n < 50 then "XL" ++ (toRoman (n - 40))
        else if n < 90 then "L" ++ (toRoman (n - 50))
        else if n < 100 then "XC" ++ (toRoman (n - 90))
        else if n < 400 then "C" ++ (toRoman (n - 100))
        else if n < 500 then "CD" ++ (toRoman (n - 400))
        else if n < 900 then "D" ++ (toRoman (n - 500))
        else if n < 1000 then "CM" ++ (toRoman (n - 900))
        else "M" ++ (toRoman (n - 1000))
