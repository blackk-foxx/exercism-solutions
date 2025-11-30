module Bob exposing (hey)

import Char exposing (isAlpha, isUpper)
import String exposing (dropLeft, filter, length, trim, uncons)

all : (Char -> Bool) -> String -> Bool
all pred str = case uncons str of
    Nothing -> False
    Just(c, "") -> pred c
    Just(c, xs) -> pred c && all pred xs

lastChar str = dropLeft ((length str) - 1) str

isYelling str = all isUpper (filter isAlpha str)

isSilence str = trim str == ""

hey : String -> String
hey remark = 
    let
        trimmedRemark = trim remark
    in
        if isSilence trimmedRemark then
            "Fine. Be that way!"
        else
            case lastChar trimmedRemark of
                "?" ->
                    if isYelling trimmedRemark then 
                        "Calm down, I know what I'm doing!"
                    else
                        "Sure."
                _ ->
                    if isYelling trimmedRemark then
                        "Whoa, chill out!"
                    else
                        "Whatever."
