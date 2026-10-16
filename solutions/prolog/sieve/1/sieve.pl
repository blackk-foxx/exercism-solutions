primes(Limit, []) :- Limit < 2, !.
primes(Limit, Primes) :-
    multiples(2, Limit, Multiples),
    primes(2, Limit, Multiples, [], RevPrimes),
    reverse(RevPrimes, Primes).

primes(N, Limit, _, Primes, Primes) :- N > Limit, !.
primes(N, Limit, Comps, PrimesIn, PrimesOut) :-
    NextN is N + 1,
    (
        member(N, Comps) -> 
            primes(NextN, Limit, Comps, PrimesIn, PrimesOut)
        ;
            multiples(N, Limit, Multiples),
            append(Multiples, Comps, NewComps),
            primes(NextN, Limit, NewComps, [N | PrimesIn], PrimesOut)
    ).

multiples(N, Max, Multiples) :-
    FirstMultiple is N + N,
    multiples(N, Max, FirstMultiple, Multiples).

multiples(_, Max, Current, []) :-
    Current > Max,
    !.

multiples(N, Max, Current, [Current | Tail]) :-
    Next is Current + N,
    multiples(N, Max, Next, Tail).
