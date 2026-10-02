from_data(Data, Tree) :- foldl(insert, Data, nil, Tree).

insert(X, nil, tree_node(X, nil, nil)).
insert(X, tree_node(Value, Left, Right), tree_node(Value, NewLeft, NewRight)) :-
    (
        X =< Value -> 
            insert(X, Left, NewLeft), NewRight = Right
        ;
            insert(X, Right, NewRight), NewLeft = Left
    ).
    
to_data(nil, []).
to_data(tree_node(Value, Left, Right), Data) :-
    to_data(Left, LeftData),
    to_data(Right, RightData),
    flatten([LeftData, Value, RightData], Data).
