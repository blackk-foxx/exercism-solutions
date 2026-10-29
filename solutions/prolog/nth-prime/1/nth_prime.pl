nth_prime(N, Prime) :-
    primes(N, Primes), last(Primes, Prime).

primes(1, [2]) :- !.
primes(2, [2, 3]) :- !.
primes(N, Primes) :-
    N > 2,
    PrevN is N - 1,
    primes(PrevN, PrevPrimes),
    last(PrevPrimes, LastPrime),
    M is LastPrime + 2,
    next_prime(M, PrevPrimes, NextPrime),
    append(PrevPrimes, [NextPrime], Primes).

next_prime(N, KnownPrimes, N) :- 
    is_prime(N, KnownPrimes), 
    !.
next_prime(N, KnownPrimes, NextPrime) :-
    NextN is N + 2,
    next_prime(NextN, KnownPrimes, NextPrime).

is_prime(_, []).
is_prime(N, [FirstPrime | _]) :- FirstPrime^2 > N, !.
is_prime(N, [FirstPrime | OtherKnownPrimes]) :-
    (N mod FirstPrime) =\= 0, 
    is_prime(N, OtherKnownPrimes).
