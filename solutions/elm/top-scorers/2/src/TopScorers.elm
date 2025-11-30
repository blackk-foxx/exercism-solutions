module TopScorers exposing (..)

import Dict exposing (Dict)
import TopScorersSupport exposing (PlayerName)


updateGoalCountForPlayer : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
updateGoalCountForPlayer playerName playerGoalCounts =
    Dict.update playerName (
        \x -> case x of 
            Just y -> Just (y+1)
            Nothing -> Just 1
        ) playerGoalCounts


aggregateScorers : List PlayerName -> Dict PlayerName Int
aggregateScorers playerNames =
    List.foldl updateGoalCountForPlayer Dict.empty playerNames


removeInsignificantPlayers : Int -> Dict PlayerName Int -> Dict PlayerName Int
removeInsignificantPlayers goalThreshold playerGoalCounts =
    Dict.filter (\_ count -> count >= goalThreshold) playerGoalCounts 


resetPlayerGoalCount : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
resetPlayerGoalCount playerName playerGoalCounts =
    Dict.insert playerName 0 playerGoalCounts


formatNameCount : PlayerName -> Int -> String
formatNameCount name count = 
    name ++ ": " ++ (count |> String.fromInt)


formatPlayer : PlayerName -> Dict PlayerName Int -> String
formatPlayer playerName playerGoalCounts =
    Dict.get playerName playerGoalCounts 
        |> Maybe.withDefault 0 |> formatNameCount playerName


formatPlayers : Dict PlayerName Int -> String
formatPlayers =
    Dict.map formatNameCount >> Dict.values >> String.join ", " 


combineGames : Dict PlayerName Int -> Dict PlayerName Int -> Dict PlayerName Int
combineGames game1 game2 = Dict.merge
    Dict.insert
    (\k v1 v2 merged -> Dict.insert k (v1 + v2) merged)
    Dict.insert
    game1
    game2
    Dict.empty
