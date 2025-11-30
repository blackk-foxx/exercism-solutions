module ArmstrongNumbers exposing (isArmstrongNumber)
import List exposing (map, sum, length)

getDigits : Int -> List Int
getDigits n = 
    if n < 10 then 
        [n]
    else
        (modBy 10 n) :: getDigits (n // 10)

isArmstrongNumber : Int -> Bool
isArmstrongNumber nb = 
    let 
        digits = getDigits nb
        raise = \n -> n ^ (length digits)
    in 
        nb == (digits |> map raise |> sum)
