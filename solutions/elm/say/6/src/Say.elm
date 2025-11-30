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

thousands = Array.fromList [
        "",
        "thousand",
        "million",
        "billion"
    ]

convert : Int -> String
convert number = 
    if number < 20 then
        convertSmallNumber number
    else if number < 100 then 
        convertMediumNumber number
    else if number < 1000 then
        convertLargeNumber number
    else
        convertReallyLargeNumber number

convertSmallNumber number = 
    get number onesAndTeens

convertMediumNumber number = 
    let
        head = get (number // 10) tens
        tailValue = modBy 10 number
    in 
        if tailValue > 0 then
            [head, "-", convert tailValue] |> String.concat
        else
            head

convertLargeNumber number = 
    convertNumberWithScale number 100 "hundred"

convertReallyLargeNumber number =
    let
        order = number |> toFloat |> logBase 1000 |> floor
    in 
        convertNumberWithScale number (1000 ^ order) (get order thousands)

convertNumberWithScale number magnitude scaleWord =
    let 
        tailValue = modBy magnitude number
        separator = 
            if tailValue == 0 then ""
            else if tailValue < 100 then " and "
            else " "
    in 
        [
            convert (number // magnitude), 
            " ", 
            scaleWord, 
            separator,
            convert tailValue
        ] |> String.concat

get number array =
    case Array.get number array of
        Nothing -> ""
        Just(s) -> s
