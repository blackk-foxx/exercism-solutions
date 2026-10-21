score([N, N, N, N, N], yacht, 50) :- !.

score(Dice, full_house, Score) :- 
    is_full_house(Dice), sumlist(Dice, Score), !.

score(Dice, four_of_a_kind, Score) :-
    get_four_of_a_kind(Dice, Group), sumlist(Group, Score), !.

score(Dice, little_straight, 30) :- sort(Dice, [1, 2, 3, 4, 5]), !.

score(Dice, big_straight, 30) :- sort(Dice, [2, 3, 4, 5, 6]), !.

score(Dice, choice, Score) :- sumlist(Dice, Score), !.

score(Dice, Category, Score) :-
    nth1(Value, [ones, twos, threes, fours, fives, sixes], Category),
    include(=(Value), Dice, Matches),
    length(Matches, Count),
    Score is Value * Count, 
    !.

score(_, _, 0).

is_full_house(Dice) :- 
    (msort(Dice, [X, X, X, Y, Y]); msort(Dice, [X, X, Y, Y, Y])), X \= Y.

get_four_of_a_kind(Dice, [X, X, X, X]) :-
    msort(Dice, [X, X, X, X, _]); msort(Dice, [_, X, X, X, X]).
