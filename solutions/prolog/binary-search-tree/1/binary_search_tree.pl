from_data(Data, Tree) :- from_data(Data, nil, Tree).
from_data([], Tree, Tree).
from_data([X | Xs], TreeIn, TreeOut) :-
    insert(X, TreeIn, NewTree),
    from_data(Xs, NewTree, TreeOut).    

insert(X, nil, tree_node(X, nil, nil)).
insert(X, tree_node(Value, Left, Right), tree_node(Value, NewLeft, NewRight)) :-
    X =< Value, insert(X, Left, NewLeft), NewRight = Right;
    insert(X, Right, NewRight), NewLeft = Left.
    
to_data(nil, []).
to_data(tree_node(Value, Left, Right), Data) :-
    to_data(Left, LeftData),
    to_data(Right, RightData),
    flatten([LeftData, Value, RightData], Data).
