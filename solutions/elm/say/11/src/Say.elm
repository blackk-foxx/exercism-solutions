module Say exposing (SayError(..), say)

type SayError
    = Negative
    | TooLarge

say : Int -> Result SayError String
say number = case number of
    0 -> Ok "zero"
    n ->
        if n < 0 then Err Negative
        else if n > 1000000000000 then Err TooLarge
        else Ok (convert n)

getOnesOrTeensWord : Int -> String
getOnesOrTeensWord n = case n of 
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    5 -> "five"
    6 -> "six"
    7 -> "seven"
    8 -> "eight"
    9 -> "nine"
    10 -> "ten"
    11 -> "eleven"
    12 -> "twelve"
    13 -> "thirteen"
    14 -> "fourteen"
    15 -> "fifteen"
    16 -> "sixteen"
    17 -> "seventeen"
    18 -> "eighteen"
    19 -> "nineteen"
    _ -> ""

getTensWord : Int -> String
getTensWord n = case n of 
    1 -> "ten"
    2 -> "twenty"
    3 -> "thirty"
    4 -> "forty"
    5 -> "fifty"
    6 -> "sixty"
    7 -> "seventy"
    8 -> "eighty"
    9 -> "ninety"
    _ -> ""

getThousandsWord : Int -> String
getThousandsWord n = case n of
    1 -> "thousand"
    2 -> "million"
    3 -> "billion"
    _ -> ""

convert : Int -> String
convert number = 
    if number < 20 then
        convertNumberLessThan20 number
    else if number < 100 then 
        convertNumberLessThan100 number
    else if number < 1000 then
        convertNumberLessThan1000 number
    else
        convertNumberLargerThan1000 number

convertNumberLessThan20 : Int -> String
convertNumberLessThan20 number = 
    getOnesOrTeensWord number

convertNumberLessThan100 : Int -> String
convertNumberLessThan100 number = 
    let
        head = getTensWord (number // 10)
        tailValue = modBy 10 number
        words = if tailValue > 0 then
                [head, "-", convert tailValue]
            else
                [head]
    in 
        words |> String.concat

convertNumberLessThan1000 : Int -> String
convertNumberLessThan1000 number = 
    convertNumberWithScale number 100 "hundred"

getThousandsOrder : Int -> Int
getThousandsOrder n = 
    n |> toFloat |> logBase 1000 |> floor

convertNumberLargerThan1000 : Int -> String
convertNumberLargerThan1000 number =
    let
        order = getThousandsOrder number
    in 
        convertNumberWithScale number (1000 ^ order) (getThousandsWord order)

convertNumberWithScale : Int -> Int -> String -> String
convertNumberWithScale number magnitude scaleWord =
    let 
        tailValue = modBy magnitude number
    in 
        [
            convert (number // magnitude), 
            " ", 
            scaleWord, 
            getSeparator tailValue,
            convert tailValue
        ] |> String.concat

getSeparator : Int -> String
getSeparator value = 
    if value == 0 then ""
    else if value < 100 then " and "
    else " "
