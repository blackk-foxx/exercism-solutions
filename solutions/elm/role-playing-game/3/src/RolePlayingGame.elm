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
        let mana = if level >= 10 then Just 100 else Nothing
        in Just (Player name level 100 mana)
    else Nothing


castSpell : Int -> Player -> ( Player, Int )
castSpell manaCost {name, level, health, mana} =
    case mana of
        Nothing -> 
            let newHealth = if health >= manaCost then health - manaCost else 0
            in ((Player name level newHealth Nothing), 0)
        Just x -> 
            let (newMana, damage) = if x >= manaCost then 
                        (Just (x - manaCost), 2 * manaCost)
                    else 
                        (mana, 0)
            in ((Player name level health newMana), damage)
