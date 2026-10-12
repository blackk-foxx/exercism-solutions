valid(String) :-
    string_digits(String, Digits),
    checksum(Digits, Checksum),
    0 is Checksum mod 10.

string_digits(String, Digits) :-
    string_chars(String, Chars),
    exclude([C] >> (C == ' '), Chars, NonspaceChars),
    maplist(char_number, NonspaceChars, Digits).

char_number(Char, Number) :-
    char_type(Char, digit),
    number_chars(Number, [Char]).

checksum(Digits, Checksum) :-
    length(Digits, Len),
    Len > 1,
    reverse(Digits, RevDigits),
    foldl(accumulate_digit, RevDigits, 1-0, _-Checksum).

accumulate_digit(Digit, MultiplierIn-SumIn, MultiplierOut-SumOut) :-
    clipped(Digit * MultiplierIn, ModifiedDigit),
    SumOut is SumIn + ModifiedDigit,
    MultiplierOut is (MultiplierIn mod 2) + 1.

clipped(Value, Value) :- Value < 10, !.
clipped(Value, Value - 9).
