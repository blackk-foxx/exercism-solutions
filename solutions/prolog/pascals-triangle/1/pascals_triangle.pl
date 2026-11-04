pascal(0, []) :- !.
pascal(NumRows, Rows) :-
    accumulate_rows(1, NumRows, [[1]], RevRows),
    reverse(RevRows, Rows).

accumulate_rows(MaxN, MaxN, Rows, Rows) :- !.
accumulate_rows(N, MaxN, [PrevRow | AccTail], Rows) :-
    next_row(PrevRow, Row),
    NextN is N + 1,
    accumulate_rows(NextN, MaxN, [Row | [PrevRow| AccTail]], Rows).

next_row(Row, NextRow) :-
    pairs(Row, Pairs),
    maplist(sumlist, Pairs, Sums),
    flatten([[1], Sums, [1]], NextRow).

pairs([_], []) :- !.
pairs([X, Y], [[X, Y]]) :- !.
pairs([X, Y | Tail], [[X, Y] | TailPairs]) :-
    pairs([Y | Tail], TailPairs).

    