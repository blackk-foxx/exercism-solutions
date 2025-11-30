module Say exposing (SayError(..), say)

import Array

type SayError
    = Negative
    | TooLarge

ones = Array.fromList [
        "",
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine"
    ]

teens = Array.fromList [
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

thousandPowers = Array.fromList [
        "",
        "thousand",
        "million",
        "billion"
    ]
    
unwrap maybeStr = case maybeStr of
    Nothing -> ""
    Just(s) -> s

validate number = 
    if number < 0 then Err(Negative)
    else if number > 1000000000000 then Err(TooLarge)
    else Ok(number)

prepend prefix str = case str of
    "" -> ""
    s -> prefix ++ s

convertNonZero number = 
    if number < 10 then
        Array.get number ones |> unwrap
    else if number < 20 then
        Array.get (number-10) teens |> unwrap
    else if number < 100 then
        let 
            tensWord = (Array.get (number//10) tens |> unwrap) 
            remainder = modBy 10 number |> convertNonZero
        in tensWord ++ (remainder|> prepend "-")
    else 
        let
            hundredsWord = (Array.get (number//100) ones |> unwrap) ++ " hundred"
            remainder = modBy 100 number |> convertNonZero
        in hundredsWord ++ (remainder |> prepend " and ")

insertScaleWords words = case words of
    [] -> []
    [""] -> []
    [x] -> [x]
    quantity::xs -> case quantity of
        "" -> insertScaleWords xs
        nonZeroQuantity ->
            let scaleWord = Array.get (List.length xs) thousandPowers |> unwrap
            in [nonZeroQuantity, scaleWord] ++ (insertScaleWords xs)

chunkify number = 
    if number < 1000 then
        [number]
    else
        (chunkify (number // 1000)) ++ [modBy 1000 number]

insertAtPenultimatePosition newWord words = case words of
    [] -> []
    [a] -> [newWord, a]
    x::xs -> x :: insertAtPenultimatePosition newWord xs

hasDanglingOnes chunks = case chunks of
    [] -> False
    [_] -> False
    [0, 0] -> False
    [0, _] -> True
    _::xs -> hasDanglingOnes xs
    
handleDanglingOnes chunks words = 
    if hasDanglingOnes chunks then
        insertAtPenultimatePosition "and" words
    else
        words
        
convert number = case number of
    0 -> "zero"
    n -> 
        let chunks = chunkify n
        in chunks
            |> List.map convertNonZero
            |> insertScaleWords
            |> handleDanglingOnes chunks
            |> String.join " "
    
say : Int -> Result SayError String
say = validate >> Result.map convert
