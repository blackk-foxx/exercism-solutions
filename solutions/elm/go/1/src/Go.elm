module Go exposing (..)

import GoSupport exposing (..)

applyRulesList : Game -> List Rule -> Result String Game
applyRulesList game rules = case rules of
    [] -> Ok(game)
    r::xs -> case r game of
        Ok(g) -> applyRulesList g xs
        Err(e) -> Err(e)

applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
    case applyRulesList game [
        oneStonePerPointRule,
        (\g -> Ok(captureRule g)),
        libertyRule,
        koRule
    ] of
        Ok(g) -> changePlayer g
        Err(e) -> {game | error = e}
        