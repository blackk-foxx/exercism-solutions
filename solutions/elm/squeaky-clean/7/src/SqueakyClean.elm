module SqueakyClean exposing (clean, clean1, clean2, clean3, clean4)

import Char exposing (isDigit, toUpper)
import String exposing (concat, contains, cons, filter, replace, split, uncons)

clean1 : String -> String
clean1 str = replace " " "_" str

clean2 : String -> String
clean2 str = 
    let
        cleanDelim : String -> String 
        cleanDelim d = if (contains d "\n\t\r") then "[CTRL]" else d
        prependCleanDelim : Char -> String -> String
        prependCleanDelim d s = (d |> String.fromChar |> cleanDelim) ++ s
    in
        str |> clean1 |> String.foldr prependCleanDelim ""

clean3 : String -> String
clean3 str = 
    let 
        capitalize s = case uncons s of
            Nothing -> ""
            Just (c, xs) -> cons (toUpper c) xs
        toCamelCase s = case split "-" s of
            [] -> ""
            (x::xs) -> x :: (xs |> List.map capitalize) |> concat
    in
        str |> clean2 |> toCamelCase

clean4 : String -> String
clean4 str = str |> clean3 |> filter (\c -> not (isDigit c))

isLowercaseGreekLetter : Char -> Bool
isLowercaseGreekLetter c =
    let 
        alpha = (Char.toCode 'α')
        omega = (Char.toCode 'ω')
    in
        alpha <= (Char.toCode c) && (Char.toCode c) <= omega
    

clean : String -> String
clean str =
        str |> clean4 |> filter (\c -> not (isLowercaseGreekLetter c))

