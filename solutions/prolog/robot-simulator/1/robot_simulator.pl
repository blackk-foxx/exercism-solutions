create(X, Y, Direction, robot(coordinate(x(X), y(Y)), direction(Direction))).

move(Robot, Instructions, Moved) :-
    string_chars(Instructions, InstructionChars),
    foldl(execute, InstructionChars, Robot, Moved).

execute('A', robot(P, direction(D)), robot(NewP, direction(D))) :-
    advance(P, D, NewP), !.

execute('R', robot(P, direction(D)), robot(P, direction(NewD))) :-
    rotate90(D, NewD), !.

execute('L', robot(P, direction(D)), robot(P, direction(NewD))) :-
    rotate90(NewD, D).

rotate90(north, east).
rotate90(east, south).
rotate90(south, west).
rotate90(west, north).

advance(coordinate(x(X), y(Y)), Direction, coordinate(x(NewX), y(NewY))) :-
    OffsetForDirection = [north-(0, 1), east-(1, 0), south-(0, -1), west-(-1, 0)],
    member(Direction-(XOffset, YOffset), OffsetForDirection),
    NewX is X + XOffset,
    NewY is Y + YOffset.
