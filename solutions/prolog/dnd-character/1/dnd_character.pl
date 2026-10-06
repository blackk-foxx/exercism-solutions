modifier(Score, Modifier) :- Modifier is floor((Score - 10) / 2).
ability(Score) :- random_between(3, 18, Score).
create_character(character(
        strength(Strength),
        dexterity(Dexterity),
        constitution(Constitution),
        intelligence(Intelligence),
        wisdom(Wisdom),
        charisma(Charisma),
        hitpoints(Hitpoints)
    )) :-
        ability(Strength),
        ability(Dexterity),
        ability(Constitution),
        ability(Intelligence),
        ability(Wisdom),
        ability(Charisma),
        modifier(Constitution, Modifier),
        Hitpoints is 10 + Modifier.
