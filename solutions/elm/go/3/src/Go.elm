module Go exposing (..)

import GoSupport exposing (..)
import Result exposing (andThen, map)

applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
    case game |> oneStonePerPointRule
        |> map captureRule
        |> andThen libertyRule
        |> andThen koRule of
            Ok(g) -> changePlayer g
            Err(e) -> {game | error = e}
        