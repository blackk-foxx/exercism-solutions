create(X, Y, Direction, robot(coordinate(x(X), y(Y)), direction(Direction))).

move(Robot, Instructions, Moved) :-
    string_chars(Instructions, InstructionChars),
    foldl(execute, InstructionChars, Robot, Moved).

execute('A', 
        robot(coordinate(x(X), y(Y)), direction(D)), 
        robot(coordinate(x(NewX), y(NewY)), direction(D))
    ) :- advance((X, Y), D, (NewX, NewY)), !.

execute('R', robot(P, direction(D)), robot(P, direction(NewD))) :-
    rotate90(D, NewD), !.

execute('L', robot(P, direction(D)), robot(P, direction(NewD))) :-
    rotate90(NewD, D).

rotate90(north, east).
rotate90(east, south).
rotate90(south, west).
rotate90(west, north).

advance((X, Y), north, (X, NewY)) :- NewY is Y + 1.
advance((X, Y), east, (NewX, Y)) :- NewX is X + 1.
advance((X, Y), south, (X, NewY)) :- NewY is Y - 1.
advance((X, Y), west, (NewX, Y)) :- NewX is X - 1.
