score([N, N, N, N, N], yacht, 50) :- !.
score(_, yacht, 0) :- !.
score(Dice, full_house, Score) :-
    is_full_house(Dice),
    sumlist(Dice, Score),
    !.
score(_, full_house, 0) :- !.
score(Dice, four_of_a_kind, Score) :-
    msort(Dice, [X, X, X, X, _]),
    sumlist([X, X, X, X], Score),
    !.
score(Dice, four_of_a_kind, Score) :-
    msort(Dice, [_, X, X, X, X]),
    sumlist([X, X, X, X], Score),
    !.
score(_, four_of_a_kind, 0) :- !.
score(Dice, little_straight, 30) :- 
    sort(Dice, [1, 2, 3, 4, 5]), !.
score(_, little_straight, 0) :- !.
score(Dice, big_straight, 30) :-
    sort(Dice, [2, 3, 4, 5, 6]), !.
score(_, big_straight, 0) :- !.
score(Dice, choice, Score) :- sumlist(Dice, Score), !.
score(Dice, Category, Score) :-
    call(Category, Value),
    include(=(Value), Dice, Matches),
    length(Matches, Count),
    Score is Value * Count.

is_full_house(Dice) :- msort(Dice, [X, X, X, Y, Y]), X \= Y.
is_full_house(Dice) :- msort(Dice, [X, X, Y, Y, Y]), X \= Y.

ones(1).
twos(2).
threes(3).
fours(4).
fives(5).
sixes(6).
