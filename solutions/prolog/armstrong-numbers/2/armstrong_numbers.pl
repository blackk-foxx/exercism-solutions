number_to_digits(Number, Digits) :-
    number_chars(Number, Chars),
    maplist(atom_number, Chars, Digits).

power(Exponent, Number, Power) :-
    Power is Number ^ Exponent.

armstrong_number(N) :-
    number_to_digits(N, Digits),
    length(Digits, NumDigits),
    maplist(power(NumDigits), Digits, Powers),
    sumlist(Powers, N).
