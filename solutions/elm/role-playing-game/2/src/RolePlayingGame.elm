module RolePlayingGame exposing (Player, castSpell, introduce, revive)


type alias Player =
    { name : Maybe String
    , level : Int
    , health : Int
    , mana : Maybe Int
    }


introduce : Player -> String
introduce { name } = Maybe.withDefault "Mighty Magician" name


revive : Player -> Maybe Player
revive {name, level, health} = 
    if health == 0 then 
        if level >= 10 then
            Just (Player name level 100 (Just 100))
        else
            Just (Player name level 100 Nothing)
    else Nothing


castSpell : Int -> Player -> ( Player, Int )
castSpell manaCost {name, level, health, mana} =
    case mana of
        Nothing -> 
            if health >= manaCost then
                ((Player name level (health - manaCost) Nothing), 0)
            else
                ((Player name level 0 Nothing), 0)
        Just x -> 
            if x >= manaCost then 
                (Player name level health (Just (x - manaCost)), 2 * manaCost)
            else
                ((Player name level health mana), 0)
