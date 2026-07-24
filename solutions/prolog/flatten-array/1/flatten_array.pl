flatten_list([], []).

flatten_list([nil | Tail], Flattened) :-
    flatten_list(Tail, Flattened), !.

flatten_list([Head | Tail], Flattened) :- 
    is_list(Head),
    flatten_list(Head, FlattenedHead),
    flatten_list(Tail, FlattenedTail),
    append(FlattenedHead, FlattenedTail, Flattened),
    !.

flatten_list([Head | Tail], Flattened) :-
    flatten_list(Tail, FlattenedTail),
    Flattened = [Head | FlattenedTail].
