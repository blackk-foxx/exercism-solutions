create_rational(Numerator, Denominator, Rational) :-
    reduce(rational(Numerator, Denominator), Rational).

add(rational(N1, D1), rational(N2, D2), Result) :-
    ResultN is N1 * D2 + N2 * D1,
    ResultD is D1 * D2,
    create_rational(ResultN, ResultD, Result).

sub(rational(N1, D1), rational(N2, D2), Result) :-
    ResultN is N1 * D2 - N2 * D1,
    ResultD is D1 * D2,
    create_rational(ResultN, ResultD, Result).

mul(rational(N1, D1), rational(N2, D2), Result) :-
    ResultN is N1 * N2,
    ResultD is D1 * D2,
    create_rational(ResultN, ResultD, Result).

div(rational(N1, D1), rational(N2, D2), Result) :-
    N2 \= 0,
    ResultN is N1 * D2,
    ResultD is N2 * D1,
    create_rational(ResultN, ResultD, Result).

abs(rational(N, D), Result) :-
    ResultN is abs(N), ResultD is abs(D),
    create_rational(ResultN, ResultD, Result).

pow(rational(N, D), Power, Result) :-
    Power >= 0, 
    ResultN is N^Power, ResultD is D^Power, 
    create_rational(ResultN, ResultD, Result),
    !.
pow(rational(N, D), Power, Result) :-
    Power < 0,
    ResultN is D^abs(Power), ResultD is N^abs(Power),
    create_rational(ResultN, ResultD, Result),
    !.
pow(X, rational(N, D), Result) :-
    Result is (X^N) ^ (1/D).

reduce(rational(N, D), rational(NewN, NewD)) :-
    gcd(N, D, GCD), NewN is N // GCD, NewD is D // GCD.

gcd(X, 0, X) :- !.
gcd(X, Y, Z) :- 
    Rem is X rem Y, 
    gcd(Y, Rem, Z).