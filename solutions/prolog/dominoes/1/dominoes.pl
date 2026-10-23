can_chain(Pieces) :-
    permutation(Pieces, P),
    is_chain(P).

is_chain([]) :- !.
is_chain([(X, X)]) :- !. 
is_chain(Pieces) :-
    Pieces = [(X, _) | Rest],
    last(Rest, (_, X)),
    is_open_chain(Pieces).

is_open_chain([(_, X), (X, _)]) :- !.
is_open_chain([(_, X), (X, Y) | Tail]) :-
    is_open_chain([(X, Y) | Tail]).
is_open_chain([(_, X), (Y, X) | Tail]) :-
    is_open_chain([(X, Y) | Tail]).
