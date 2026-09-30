sublist(X, Y, sublist) :-
    append(Prefix, _, Y),
    append(_, X, Prefix).

sublist(X, X, equal).
sublist(X, Y, superlist) :- sublist(Y, X, sublist).
sublist(_, _, unequal).
