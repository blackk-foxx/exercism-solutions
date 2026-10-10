isbn(Input) :-
    string_chars(Input, Chars),
    include(is_alphanum, Chars, Digits),
    length(Digits, 10),
    reverse(Digits, [CheckDigit | NormalDigits]),
    maplist(atom_number, NormalDigits, Numbers),
    checksum(Numbers, Checksum),
    check_digit_number(CheckDigit, CheckDigitValue),
    0 is (Checksum + CheckDigitValue) mod 11.

is_alphanum(Char) :- char_type(Char, alnum).

check_digit_number('X', 10) :- !.
check_digit_number(Digit, Number) :- atom_number(Digit, Number).

checksum(Numbers, Checksum) :-
    numlist(2, 10, Multipliers),
    maplist(multiply, Numbers, Multipliers, Multiples),
    sumlist(Multiples, Checksum).

multiply(A, B, Result) :- Result is A * B.
