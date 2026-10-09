water_drinker(Drinker) :- 
    solve(Street), 
    member(house(_, nationality(Drinker), _, drink(water), _, _), Street),
    !.

zebra_owner(Owner) :-
    solve(Street),
    member(house(_, nationality(Owner), pet(zebra), _, _, _), Street),
    !.

solve(Street) :-
    % There are five houses.
    numlist(0, 4, Addresses),
    maplist(house_at_address, Addresses, Street),
    
    % The Englishman lives in the red house.
    member(house(color(red), nationality(english), _, _, _, _), Street),

    % The Spaniard owns the dog.
    member(house(_, nationality(spanish), pet(dog), _, _, _), Street),

    % The person in the green house drinks coffee.
    member(house(color(green), _, _, drink(coffee), _, _), Street),

    % The Ukrainian drinks tea.
    member(house(_, nationality(ukrainian), _, drink(tea), _, _), Street),

    % The green house is immediately to the right of the ivory house.
    ordered_neighbors(
            house(color(ivory), _, _, _, _, _), 
            house(color(green), _, _, _, _, _), 
            Street
        ),

    % The snail owner likes to go dancing.
    member(house(_, _, pet(snail), _, hobby(dancing), _), Street),

    % The person in the yellow house is a painter.
    member(house(color(yellow), _, _, _, hobby(painting), _), Street),

    % The person in the middle house drinks milk.
    member(house(_, _, _, drink(milk), _, address(2)), Street),

    % The Norwegian lives in the first house.
    member(house(_, nationality(norwegian), _, _, _, address(0)), Street),

    % The person who enjoys reading lives in the house next to the person with the fox.
    neighbors(
            house(_, _, _, _, hobby(reading), _), 
            house(_, _, pet(fox), _, _, _), 
            Street
        ),

    % The painter's house is next to the house with the horse.
    neighbors(
            house(_, _, _, _, hobby(painting), _), 
            house(_, _, pet(horse), _, _, _), 
            Street
        ),

    % The person who plays football drinks orange juice.
    member(house(_, _, _, drink(orange_juice), hobby(football), _), Street),

    % The Japanese person plays chess.
    member(house(_, nationality(japanese), _, _, hobby(chess), _), Street),

    % The Norwegian lives next to the blue house.
    neighbors(
            house(_, nationality(norwegian), _, _, _, _), 
            house(color(blue), _, _, _, _, _), 
            Street
        ),

    % Implied rules...
    member(house(_, _, pet(zebra), _, _, _), Street),
    member(house(_, _, _, drink(water), _, _), Street).
    
house_at_address(A, house(_, _,_, _, _, address(A))).

ordered_neighbors(
    	house(C1, N1, P1, D1, H1, address(Address1)), 
        house(C2, N2, P2, D2, H2, address(Address2)),
        Street
    ) :-
	member(house(C1, N1, P1, D1, H1, address(Address1)), Street),
    member(house(C2, N2, P2, D2, H2, address(Address2)), Street),
    Address2 is Address1 + 1.

neighbors(
    	house(C1, N1, P1, D1, H1, address(Address1)), 
        house(C2, N2, P2, D2, H2, address(Address2)),
        Street
    ) :-
	member(house(C1, N1, P1, D1, H1, address(Address1)), Street),
    member(house(C2, N2, P2, D2, H2, address(Address2)), Street),
    1 is abs(Address1 - Address2).

