module BinarySearch exposing (find)

import Array exposing (Array)

findWithOffset : Int -> Int -> Array Int -> Maybe Int
findWithOffset target offset xs = 
    let
        length = Array.length xs
        midpoint = length // 2
        left = Array.slice 0 midpoint xs
        right = Array.slice (midpoint + 1) length xs
    in
        case Array.get midpoint xs of
            Nothing -> Nothing
            Just(n) -> 
                if target == n then Just(offset + midpoint) 
                else if target < n then findWithOffset target offset left
                else findWithOffset target (offset + midpoint + 1) right

find : Int -> Array Int -> Maybe Int
find target xs = findWithOffset target 0 xs