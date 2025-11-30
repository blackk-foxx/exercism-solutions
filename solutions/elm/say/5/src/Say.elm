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

get number array =
    case Array.get number array of
        Nothing -> ""
        Just(s) -> s
    
convert number = 
    if number < 20 then
        get number onesAndTeens
    else if number < 100 then 
        convertMediumNumber number
    else if number < 1000 then
        convertLargeNumber number 100 "hundred"
    else if number < 1000000 then
        convertLargeNumber number 1000 "thousand"
    else if number < 1000000000 then
        convertLargeNumber number 1000000 "million"
    else
        convertLargeNumber number 1000000000 "billion"

convertMediumNumber number = 
    let
        head = get (number // 10) tens
        tailValue = modBy 10 number
    in 
        if tailValue > 0 then
            [head, "-", convert tailValue] |> String.concat
        else
            head

convertLargeNumber number magnitude scaleWord =
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
            