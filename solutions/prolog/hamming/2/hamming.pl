hamming_distance(Str1, Str2, Dist) :-
    string_chars(Str1, Chars1),
    string_chars(Str2, Chars2),
    maplist(pair, Chars1, Chars2, Pairs),
    exclude(same, Pairs, Diffs),
    length(Diffs, Dist).

same(X-Y) :- X = Y.

pair(X, Y, X-Y).
