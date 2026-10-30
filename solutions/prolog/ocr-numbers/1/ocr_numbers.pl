convert(Input, Output) :-
    separate_rows(Input, DigitLists),
    maplist(
        maplist(convert_digit), DigitLists, DigitCharLists
    ),
    maplist(atomic_list_concat, DigitCharLists, Atoms),
    atomic_list_concat(Atoms, ',', CombinedAtoms),
    atom_string(CombinedAtoms, Output).

separate_rows([], []) :- !.
separate_rows([S1, S2, S3, S4 | Tail], [HeadList | TailLists]) :-
    separate_digits([S1, S2, S3, S4], HeadList),
    separate_rows(Tail, TailLists).

separate_digits(["", "", "", ""], []) :- !.
separate_digits([S1, S2, S3, S4], [HeadDigit | TailDigits]) :-
    maplist(take(3), [S1, S2, S3, S4], HeadDigit, TailStrings),
    separate_digits(TailStrings, TailDigits).

convert_digit([
        " _ ",
        "| |",
        "|_|",
        "   "
    ], '0') :- !.

convert_digit([
        "   ",
        "  |",
        "  |",
        "   "
    ], '1') :- !.

convert_digit([
        " _ ",
        " _|",
        "|_ ",
        "   "
    ], '2') :- !.

convert_digit([
        " _ ",
        " _|",
        " _|",
        "   "
    ], '3') :- !.

convert_digit([
        "   ",
        "|_|",
        "  |",
        "   "
    ], '4') :- !.

convert_digit([
        " _ ",
        "|_ ",
        " _|",
        "   "
    ], '5') :- !.

convert_digit([
        " _ ",
        "|_ ",
        "|_|",
        "   "
    ], '6') :- !.

convert_digit([
        " _ ",
        "  |",
        "  |",
        "   "
    ], '7') :- !.

convert_digit([
        " _ ",
        "|_|",
        "|_|",
        "   "
    ], '8') :- !.

convert_digit([
        " _ ",
        "|_|",
        " _|",
        "   "
    ], '9') :- !.

convert_digit([S1, S2, S3, S4], '?') :-
    maplist(string_length, [S1, S2, S3, S4], [3, 3, 3, 3]), !.

take(N, String, Head, Tail) :-
    sub_string(String, 0, N, After, Head),
    sub_string(String, N, After, 0, Tail).
