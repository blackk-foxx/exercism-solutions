string_numlist(String, NumList) :-
    split_string(String, " ", "", StringList),
    maplist(number_string, NumList, StringList).

rows(Matrix, Rows) :-
    string_lines(Matrix, Lines),
    maplist(string_numlist, Lines, Rows).

row(Matrix, Y, Row) :-
    rows(Matrix, Rows),
    nth1(Y, Rows, Row).

column(Matrix, X, Column) :-
    rows(Matrix, Rows),
    maplist(nth1(X), Rows, Column).
