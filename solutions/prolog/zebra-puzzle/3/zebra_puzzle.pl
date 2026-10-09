water_drinker(Drinker) :- 
    solve(Street), 
    member(house(_, nationality(Drinker), _, drink(water), _), Street),
    !.

zebra_owner(Owner) :-
    solve(Street),
    member(house(_, nationality(Owner), pet(zebra), _, _), Street),
    !.

solve(Street) :-
    % There are five houses.
    length(Street, 5),
    
    % The Englishman lives in the red house.
    member(house(color(red), nationality(english), _, _, _), Street),

    % The Spaniard owns the dog.
    member(house(_, nationality(spanish), pet(dog), _, _), Street),

    % The person in the green house drinks coffee.
    member(house(color(green), _, _, drink(coffee), _), Street),

    % The Ukrainian drinks tea.
    member(house(_, nationality(ukrainian), _, drink(tea), _), Street),

    % The green house is immediately to the right of the ivory house.
    nextto(
            house(color(ivory), _, _, _, _), 
            house(color(green), _, _, _, _), 
            Street
        ),

    % The snail owner likes to go dancing.
    member(house(_, _, pet(snail), _, hobby(dancing)), Street),

    % The person in the yellow house is a painter.
    member(house(color(yellow), _, _, _, hobby(painting)), Street),

    % The person in the middle house drinks milk.
    Street = [_, _, house(_, _, _, drink(milk), _), _, _],

    % The Norwegian lives in the first house.
    Street = [house(_, nationality(norwegian), _, _, _), _, _, _, _],

    % The person who enjoys reading lives in the house next to the person with the fox.
    neighbors(
            house(_, _, _, _, hobby(reading)), 
            house(_, _, pet(fox), _, _), 
            Street
        ),

    % The painter's house is next to the house with the horse.
    neighbors(
            house(_, _, _, _, hobby(painting)), 
            house(_, _, pet(horse), _, _), 
            Street
        ),

    % The person who plays football drinks orange juice.
    member(house(_, _, _, drink(orange_juice), hobby(football)), Street),

    % The Japanese person plays chess.
    member(house(_, nationality(japanese), _, _, hobby(chess)), Street),

    % The Norwegian lives next to the blue house.
    neighbors(
            house(_, nationality(norwegian), _, _, _), 
            house(color(blue), _, _, _, _), 
            Street
        ).

neighbors(A, B, List) :- nextto(A, B, List); nextto(B, A, List).
