module Go exposing (..)

import GoSupport exposing (..)
import Result exposing (andThen)

applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
    case game |> oneStonePerPointRule
        |> andThen (\g -> Ok(captureRule g))
        |> andThen libertyRule
        |> andThen koRule of
            Ok(g) -> changePlayer g
            Err(e) -> {game | error = e}
        