proverb([], []).
proverb([X | Xs], Lines) :-
    verses([X | Xs], Verses),
    format(string(Ending), "And all for the want of a ~w.", [X]),
    append(Verses, [Ending], Lines).
verses([], []).
verses([_], []).
verses([X, Y | Xs], Verses) :-
    format(string(Head), "For want of a ~w the ~w was lost.", [X, Y]),
    verses([Y | Xs], Tail),
    append([Head], Tail, Verses).
