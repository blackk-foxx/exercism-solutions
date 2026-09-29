classify(Number, Classification) :-
    aliquot_sum(Number, Sum),
    classify(Number, Sum, Classification).

aliquot_sum(Number, Sum) :-
    factors(Number, Factors), sumlist(Factors, Sum).

factors(N, Factors) :-
    N > 0,
    UpperBound is N // 2,
    findall(F, (between(1, UpperBound, F), N mod F =:= 0), Factors).

classify(N, N, perfect).
classify(N, Sum, abundant) :- N < Sum.
classify(_, _, deficient).