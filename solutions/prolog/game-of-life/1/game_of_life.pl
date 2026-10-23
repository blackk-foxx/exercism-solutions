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
    neighbors(Matrix, R, C, Neighbors),
    sum_list(Neighbors, NeighborCount),
    update_cell(CurrentValue, NeighborCount, NextValue).

neighbors((Rows, Height, Width), R, C, Neighbors) :-
    findall(
        Neighbor,
        (
            adjacent(R, Height, OtherR),
            adjacent(C, Width, OtherC),
            (OtherR, OtherC) \= (R, C),
            value_at(Rows, (OtherR, OtherC), Neighbor)
        ),
        Neighbors
    ).

update_cell(1, 2, 1) :- !.
update_cell(_, 3, 1) :- !.
update_cell(_, _, 0).

adjacent(VIn, Max, VOut) :-
    MinV is max(VIn - 1, 1),
    MaxV is min(VIn + 1, Max),
    between(MinV, MaxV, VOut).

value_at(Matrix, (R, C), Value) :-
    nth1(R, Matrix, Row),
    nth1(C, Row, Value).
