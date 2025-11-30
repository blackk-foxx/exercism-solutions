module SqueakyClean exposing (clean, clean1, clean2, clean3, clean4)

import String exposing (cons, filter, fromChar, join, replace, split, uncons)
import List exposing (drop, take)

clean1 : String -> String
clean1 str = replace " " "_" str

clean2 : String -> String
clean2 str = 
    let
        cleanDelims delims s = case uncons delims of 
            Nothing -> s
            Just (c, xs) -> join "[CTRL]" (split (fromChar c) (cleanDelims xs s))
    in
        cleanDelims "\n\t\r" (clean1 str)

clean3 : String -> String
clean3 str = 
    let 
        capitalize s = case uncons s of
            Nothing -> ""
            Just (c, xs) -> cons (Char.toUpper c) xs
        toCamelCase s = case split "-" s of
            [] -> ""
            (x::xs) -> join "" ([x] ++ (List.map capitalize xs))
    in
        toCamelCase (clean2 str)

clean4 : String -> String
clean4 str = filter (\c -> (not (Char.isDigit c))) (clean3 str)


clean : String -> String
clean str =
    let 
        alpha = (Char.toCode 'α')
        omega = (Char.toCode 'ω')
        isLowercaseGreekChar c = alpha <= (Char.toCode c) && (Char.toCode c) <= omega
    in
        filter (\c -> (not (isLowercaseGreekChar c))) (clean4 str)
