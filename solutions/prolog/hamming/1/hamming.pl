hamming_distance(Str1, Str2, Dist) :-
    string_chars(Str1, Chars1),
    string_chars(Str2, Chars2),
    maplist(diff, Chars1, Chars2, Diffs),
    sumlist(Diffs, Dist).

diff(X, Y, 0) :- X = Y, !.
diff(X, Y, 1).
