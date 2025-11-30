module Bob exposing (hey)

import Char exposing (isAlpha, isUpper)
import String exposing (endsWith, filter, toList, trim, uncons)

isYelling str = case str |> filter isAlpha of
    "" -> False
    s -> s |> toList |> List.all isUpper

isSilence str = trim str == ""

isQuestion str = str |> trim |> endsWith "?"

hey : String -> String
hey remark = 
    if isSilence remark then
        "Fine. Be that way!"
    else if isQuestion remark then
        if isYelling remark then 
            "Calm down, I know what I'm doing!"
        else
            "Sure."
    else if isYelling remark then
        "Whoa, chill out!"
    else
        "Whatever."
