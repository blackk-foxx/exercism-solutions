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

minMediumNumber : Int
minMediumNumber = Array.length onesAndTeens

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

minLargeNumber : Int
minLargeNumber = (Array.length tens) * 10

minReallyLargeNumber : Int
minReallyLargeNumber = minLargeNumber * 10

thousands : Array.Array String
thousands = Array.fromList [
        "",
        "thousand",
        "million",
        "billion"
    ]

convert : Int -> String
convert number = 
    if number < minMediumNumber then
        convertSmallNumber number
    else if number < minLargeNumber then 
        convertMediumNumber number
    else if number < minReallyLargeNumber then
        convertLargeNumber number
    else
        convertReallyLargeNumber number

convertSmallNumber : Int -> String
convertSmallNumber number = 
    get number onesAndTeens

convertMediumNumber : Int -> String
convertMediumNumber number = 
    let
        base = Array.length tens
        head = get (number // base) tens
        tailValue = modBy base number
    in 
        if tailValue > 0 then
            [head, "-", convert tailValue] |> String.concat
        else
            head

convertLargeNumber : Int -> String
convertLargeNumber number = 
    convertNumberWithScale number minLargeNumber "hundred"

convertReallyLargeNumber : Int -> String
convertReallyLargeNumber number =
    let
        base = minReallyLargeNumber
        order = number |> toFloat |> logBase (base |> toFloat) |> floor
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
    else if value < minLargeNumber then " and "
    else " "

get : Int -> Array.Array String -> String
get number array =
    case Array.get number array of
        Nothing -> ""
        Just(s) -> s
