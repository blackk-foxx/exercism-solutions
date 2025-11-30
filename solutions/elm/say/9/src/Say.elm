module Say exposing (SayError(..), say)

import Array

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

onesAndTeens : Array.Array String
onesAndTeens = Array.fromList [
        "",
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine",
        "ten",
        "eleven",
        "twelve",
        "thirteen",
        "fourteen",
        "fifteen",
        "sixteen",
        "seventeen",
        "eighteen",
        "nineteen"
    ]

tens : Array.Array String
tens = Array.fromList [
        "",
        "ten",
        "twenty",
        "thirty",
        "forty",
        "fifty",
        "sixty",
        "seventy",
        "eighty",
        "ninety"
    ]

thousands : Array.Array String
thousands = Array.fromList [
        "",
        "thousand",
        "million",
        "billion"
    ]

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
    get number onesAndTeens

convertNumberLessThan100 : Int -> String
convertNumberLessThan100 number = 
    let
        base = 10
        head = get (number // base) tens
        tailValue = modBy base number
    in 
        if tailValue > 0 then
            [head, "-", convert tailValue] |> String.concat
        else
            head

convertNumberLessThan1000 : Int -> String
convertNumberLessThan1000 number = 
    convertNumberWithScale number 100 "hundred"

getThousandsOrder : Int -> Int
getThousandsOrder n = 
    n |> toFloat |> logBase 1000 |> floor

convertNumberLargerThan1000 : Int -> String
convertNumberLargerThan1000 number =
    let
        base = 1000
        order = getThousandsOrder number
    in 
        convertNumberWithScale number (base ^ order) (get order thousands)

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

get : Int -> Array.Array String -> String
get index array =
    Array.get index array |> Maybe.withDefault ""
