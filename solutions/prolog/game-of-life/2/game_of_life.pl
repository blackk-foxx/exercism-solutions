tick([], []) :- !.
tick(Current, Next) :-
    length(Current, Height),
    numlist(1, Height, RowNumbers),
    maplist(tick_row((Current, Height)), RowNumbers, Current, Next).

tick_row((Rows, Height), R, RowIn, RowOut) :-
    length(RowIn, Width),
    numlist(1, Width, CellNumbers),
    maplist(tick_cell((Rows, Height, Width), R), CellNumbers, RowIn, RowOut).

tick_cell(Matrix, R, C, CurrentValue, NextValue) :-
    findall(_, neighbor(Matrix, R, C), Neighbors),
    length(Neighbors, NeighborCount),
    next_cell(CurrentValue, NeighborCount, NextValue).

neighbor((Rows, Height, Width), R, C) :-
    between(-1, 1, DR),
    between(-1, 1, DC),
    OtherR is R + DR,
    OtherC is C + DC,
    (OtherR, OtherC) \= (R, C),
    value_at(Rows, (OtherR, OtherC), 1).

next_cell(1, 2, 1) :- !.
next_cell(_, 3, 1) :- !.
next_cell(_, _, 0).

value_at(Matrix, (R, C), Value) :-
    nth1(R, Matrix, Row),
    nth1(C, Row, Value).
