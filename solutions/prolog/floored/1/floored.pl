floor(Name, Floor) :-
    residents(Residents),
    nth1(Floor, Residents, Name).

residents(P) :-
    Residents = [amara, bjorn, cora, dale, emiko],
    permutation(Residents, P),
    \+ last(P, amara),
    \+ first(P, bjorn),
    \+ last(P, cora),
    \+ first(P, cora),
    higher(P, dale, bjorn),
    \+ adjacent(P, emiko, cora),
    \+ adjacent(P, cora, bjorn).    
    
first([R | _], R).

higher(List, E1, E2) :-
    nth1(Index1, List, E1),
    nth1(Index2, List, E2),
    Index1 > Index2.

adjacent(List, E1, E2) :-
    nth1(Index1, List, E1),
    nth1(Index2, List, E2),
    1 is abs(Index1 - Index2).