score(X, Y, Score) :- 
    distance_score(sqrt(X^2 + Y^2), Score).

distance_score(Distance, 0) :- Distance > 10,!.
distance_score(Distance, 1) :- Distance > 5,!.
distance_score(Distance, 5) :- Distance > 1,!.
distance_score(Distance, 10).
