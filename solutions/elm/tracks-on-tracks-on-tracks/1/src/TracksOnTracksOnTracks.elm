module TracksOnTracksOnTracks exposing (..)


newList : List String
newList = []


existingList : List String
existingList = [ "Elm", "Clojure", "Haskell" ]


addLanguage : String -> List String -> List String
addLanguage language languages = [language] ++ languages 


countLanguages : List String -> Int
countLanguages languages = List.length languages


reverseList : List String -> List String
reverseList languages =
    case languages of
        [] -> []
        x :: xs -> reverseList xs ++ [x]


excitingList : List String -> Bool
excitingList languages =
    case languages of
        [] -> False
        "Elm" :: _ -> True
        x :: xs -> (List.head xs == Just "Elm") && (List.length xs < 3)
