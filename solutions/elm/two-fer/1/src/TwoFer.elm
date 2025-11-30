module TwoFer exposing (twoFer)

stringForName : Maybe String -> String
stringForName name = case name of
    Nothing -> "you"
    Just(n) -> n

twoFer : Maybe String -> String
twoFer name = "One for " ++ stringForName name ++ ", one for me."
