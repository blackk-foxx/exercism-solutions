module SqueakyClean exposing (clean, clean1, clean2, clean3, clean4)

import Char exposing (isDigit, toUpper)
import Regex
import String exposing (concat, cons, filter, replace, split, uncons)

replaceAllMatches : String -> String -> String -> String
replaceAllMatches pattern replacement string =
    case Regex.fromString pattern of
        Nothing -> string
        Just regex -> Regex.replace regex (\_ -> replacement) string
      
capitalize : String -> String
capitalize string = case uncons string of
    Nothing -> ""
    Just (c, xs) -> cons (toUpper c) xs

isLowercaseGreekLetter : Char -> Bool
isLowercaseGreekLetter c =
    let 
        alpha = Char.toCode 'α'
        omega = Char.toCode 'ω'
        charCode = Char.toCode c
    in
        alpha <= charCode && charCode <= omega

clean1 : String -> String
clean1 string = replace " " "_" string

clean2 : String -> String
clean2 string = string |> clean1 |> replaceAllMatches "\n|\t|\r" "[CTRL]"

clean3 : String -> String
clean3 string = 
    let 
        toCamelCase s = case split "-" s of
            (x::xs) -> x :: (xs |> List.map capitalize) |> concat
            _ -> ""
    in
        string |> clean2 |> toCamelCase

clean4 : String -> String
clean4 string = string |> clean3 |> filter (not << isDigit)

clean : String -> String
clean string =
        string |> clean4 |> filter (not << isLowercaseGreekLetter)

