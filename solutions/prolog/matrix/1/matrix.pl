string_number(String, Number) :- number_string(Number, String).

string_numlist(String, NumList) :-
    split_string(String, " ", "", StringList),
    maplist(string_number, StringList, NumList).

rows(Matrix, Rows) :-
    split_string(Matrix, "\n", "", RawRows),
    maplist(string_numlist, RawRows, Rows).

row(Matrix, Y, Row) :-
    rows(Matrix, Rows),
    nth1(Y, Rows, Row).

column(Matrix, X, Column) :-
    rows(Matrix, Rows),
    maplist(nth1(X), Rows, Column).
