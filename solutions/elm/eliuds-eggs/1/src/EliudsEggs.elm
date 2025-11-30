module EliudsEggs exposing (eggCount)


eggCount : Int -> Int
eggCount n = case n of
    0 -> 0
    m -> (remainderBy 2 m) + eggCount (m // 2)
