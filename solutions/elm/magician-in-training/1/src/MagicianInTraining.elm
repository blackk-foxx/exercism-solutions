module MagicianInTraining exposing (..)

import Array exposing (Array)


getCard : Int -> Array Int -> Maybe Int
getCard index deck = Array.get index deck


setCard : Int -> Int -> Array Int -> Array Int
setCard index newCard deck = Array.set index newCard deck


addCard : Int -> Array Int -> Array Int
addCard newCard deck = Array.push newCard deck


removeCard : Int -> Array Int -> Array Int
removeCard index deck = 
    let length = Array.length deck
    in
        if index < length then
            let
                head = Array.slice 0 index deck
                tail = Array.slice (index + 1) length deck
            in Array.append head tail 
        else
            deck


evenCardCount : Array Int -> Int
evenCardCount deck = 
    let bumpIfEven n a = if modBy 2 n == 0 then a + 1 else a 
    in Array.foldl bumpIfEven 0 deck
