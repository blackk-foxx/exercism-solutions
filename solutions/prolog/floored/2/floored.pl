floor(Name, Floor) :-
    floors(Floors),
    nth1(Floor, Floors, Name).

floors(Floors) :-
    length(Floors, 5),
    floor_residents(Floors, AmaraFloor, BjornFloor, CoraFloor, DaleFloor, EmikoFloor),
    AmaraFloor \= 5,
    BjornFloor \= 1,
    between(2, 4, CoraFloor),
    DaleFloor > BjornFloor,
    \+ adjacent(EmikoFloor, CoraFloor),
    \+ adjacent(CoraFloor, BjornFloor).    

floor_residents(Floors, AmaraFloor, BjornFloor, CoraFloor, DaleFloor, EmikoFloor) :-
    nth1(AmaraFloor, Floors, amara),
    nth1(BjornFloor, Floors, bjorn),
    nth1(CoraFloor, Floors, cora),
    nth1(DaleFloor, Floors, dale),
    nth1(EmikoFloor, Floors, emiko).
    
adjacent(N1, N2) :- 1 is abs(N1 - N2).
