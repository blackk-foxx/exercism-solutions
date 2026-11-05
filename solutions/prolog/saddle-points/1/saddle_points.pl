:- use_module(library(clpfd)).

saddle_points(Rows, SaddlePoints) :-
    transpose(Rows, Columns),
    maplist(indices(max_member), Rows, TallestByRow),
    maplist(indices(min_member), Columns, ShortestByColumn),
    findall(
        (R, C),
        (
            nth1(R, TallestByRow, TallestColumns),
            nth1(C, ShortestByColumn, ShortestRows),
            member(C, TallestColumns), 
            member(R, ShortestRows)
        ),
        SaddlePoints
    ).

indices(Pred, List, Indices) :-
    call(Pred, Match, List),
    findall(Index, nth1(Index, List, Match), Indices).
