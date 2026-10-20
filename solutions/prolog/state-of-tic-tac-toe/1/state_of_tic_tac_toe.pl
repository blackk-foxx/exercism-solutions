state(Board, win) :-
    valid(Board),
    wins(Board, XWins, OWins),
    (XWins > 0; OWins > 0),
    !.

state(Board, draw) :- 
    valid(Board),
    no_blanks(Board), 
    !.

state(Board, ongoing) :-
    valid(Board).

valid(Board) :-
    max_one_winner(Board),
    x_started_and_players_took_turns(Board).

max_one_winner(Board) :-
    wins(Board, XWins, OWins),
    (XWins = 0; OWins = 0).

x_started_and_players_took_turns(Board) :-
    counts(Board, XCount, OCount),
    XODiff is XCount - OCount,
    (XODiff = 0; XODiff = 1).

wins(Board, XWins, OWins) :-
    triplets(Board, Triplets),
    count(=(['X', 'X', 'X']), Triplets, XWins),
    count(=(['O', 'O', 'O']), Triplets, OWins).

counts(Board, XCount, OCount) :-
    atomics_to_string(Board, AllTiles),
    string_chars(AllTiles, AllChars),
    count(=('X'), AllChars, XCount),
    count(=('O'), AllChars, OCount).
    
count(Predicate, List, Count) :-
    include(Predicate, List, Result),
    length(Result, Count).

triplets(Board, Triplets) :-
    maplist(string_chars, Board, Rows),
    maplist(
        column_ish(Rows), 
        [
            [0, 0, 0], 
            [1, 1, 1], 
            [2, 2, 2],
            [0, 1, 2],
            [2, 1, 0]
        ],
        Others
    ),
    append(Rows, Others, Triplets).

no_blanks(Board) :-
    atomics_to_string(Board, Squares),
    split_string(Squares, " ", "", Chunks),
    length(Chunks, 1).

column_ish(Rows, ColumnIndices, Tiles) :-
    maplist([C, Row] >> nth0(C, Row), ColumnIndices, Rows, Tiles).
    