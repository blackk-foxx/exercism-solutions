custom_length([], 0).
custom_length([_ | Tail], Length) :-
    custom_length(Tail, TailLength),
    Length is 1 + TailLength.

custom_append([], L, L) :- !.
custom_append(L, [], L) :- !.
custom_append([Head], [Mid | Tail], [Head, Mid | Tail]) :- !.
custom_append([Head | Mid], Tail, Result) :-
    custom_append(Mid, Tail, TailAppended),
    custom_append([Head], TailAppended, Result).

custom_concat([], []).
custom_concat([L], L) :- !.
custom_concat([A | Rest], Result) :-
    custom_concat(Rest, RestConcatenated),
    custom_append(A, RestConcatenated, Result).

custom_reverse([], []).
custom_reverse([X | Rest], Result) :-
    custom_reverse(Rest, RestReversed),
    custom_append(RestReversed, [X], Result).

custom_map(_, [], []) :- !.
custom_map(Goal, [X | Rest], Mapped) :-
    call(Goal, X, GoalForX),
    custom_map(Goal, Rest, RestMapped),
    custom_append([GoalForX], RestMapped, Mapped).

custom_filter(_, [], []) :- !.
custom_filter(Goal, [X | Rest], [X | RestFiltered]) :-
    call(Goal, X),
    custom_filter(Goal, Rest, RestFiltered),
    !.
custom_filter(Goal, [X | Rest], RestFiltered) :-
    custom_filter(Goal, Rest, RestFiltered).

custom_foldl(_, State, [], State) :- !.
custom_foldl(Goal, State, [X | Rest], Folded) :-
    call(Goal, State, X, NewState),
    custom_foldl(Goal, NewState, Rest, Folded).

custom_foldr(_, [], State, State) :- !.
custom_foldr(Goal, [X | Rest], State, Folded) :-
    custom_foldr(Goal, Rest, State, NewState),
    call(Goal, X, NewState, Folded).
