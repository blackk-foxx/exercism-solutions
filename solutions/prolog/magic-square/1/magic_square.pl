:- use_module(library(clpfd)).

magic_square(Rows) :-
    transpose(Rows, Columns),
    diagonals(Rows, Diagonals),
    maplist(sumlist, Rows, RowSums),
    maplist(sumlist, Columns, ColumnSums),
    maplist(sumlist, Diagonals, DiagonalSums),
    flatten([RowSums, ColumnSums, DiagonalSums], Sums),
    sort(Sums, SortedSums),
    length(SortedSums, 1).

diagonals(Rows, [FallingDiagonal, RisingDiagonal]) :-
    length(Rows, Length),
    numlist(1, Length, Indices),
    reverse(Indices, RevIndices),
    maplist([C, Row] >> nth1(C, Row), Indices, Rows, FallingDiagonal),
    maplist([C, Row] >> nth1(C, Row), RevIndices, Rows, RisingDiagonal).
