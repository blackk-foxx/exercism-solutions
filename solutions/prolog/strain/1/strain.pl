keep(_, [], []) :- !.
keep(Goal, [X|Xs], [X|Rest]) :-
    call(Goal, X), 
    keep(Goal, Xs, Rest),
    !.
keep(Goal, [_|Xs], Filtered) :-
    keep(Goal, Xs, Filtered).

discard(Goal, List, Filtered) :-
    keep(not(Goal), List, Filtered).

not(P, X) :- \+ call(P, X).
