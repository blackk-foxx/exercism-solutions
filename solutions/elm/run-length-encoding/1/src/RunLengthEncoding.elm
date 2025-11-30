module RunLengthEncoding exposing (decode, encode)
import String exposing (cons, dropLeft, fromChar, fromInt, left, length, toInt, uncons)
import Char exposing (isDigit)

encode : String -> String
encode string = 
    let
        countAtStart char str = case uncons str of
            Nothing -> 0
            Just(c, xs) -> 
                if c == char then 1 + countAtStart char xs
                else 0 
    in
        case uncons string of
            Nothing -> ""
            Just(c, xs) -> case countAtStart c xs of
                0 -> cons c (encode xs)
                n -> (fromInt (n + 1)) ++ (cons c (encode (dropLeft n xs)))

decode : String -> String
decode string = 
    let
        takeDigits str = case uncons str of
            Nothing -> ""
            Just(c, xs) -> 
                if (isDigit c) then cons c (takeDigits xs)
                else ""
        repeat count char = case count of 
            0 -> ""
            n -> cons char (repeat (n-1) char)
        splitDigitsFromString str = 
            let digits = takeDigits string
            in (takeDigits str, dropLeft (length digits) str)
    in
        --TODO: (maybe) simplify by inverting the cases
        case splitDigitsFromString string of
            (digits, str) -> case (toInt digits) of
                Nothing -> case uncons str of
                    Nothing -> ""
                    Just(c, xs) -> cons c (decode xs)
                Just(n) -> case uncons str of
                    Nothing -> ""
                    Just(c, xs) -> (repeat n c) ++ (decode xs)
