factors(N, Factors) :-
    factors(N, 2, Factors).

factors(1, _, []) :- !.
factors(N, Factor, [Factor | NextFactors]) :-
    0 is N mod Factor, 
    NewN is N // Factor,
    factors(NewN, Factor, NextFactors).
factors(N, Factor, Factors) :-
    NewFactor is Factor + 1,
    factors(N, NewFactor, Factors).
