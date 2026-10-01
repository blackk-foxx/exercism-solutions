sum_of_multiples([], _, 0).
sum_of_multiples(Factors, Limit, Sum) :-
    Max is Limit - 1,
    setof(M, (between(0, Max, M), multiple(Factors, M)), Multiples),
    sumlist(Multiples, Sum).

multiple(Factors, Multiple) :-
    member(F, Factors), Multiple mod F =:= 0.
