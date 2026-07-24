binary(String, Decimal) :-
    string_chars(String, Chars),
    reverse(Chars, RevChars),
    decode(RevChars, 0, Decimal).

decode([], _, 0).

decode([Head | Rest], Bit, Decimal) :-
    NextBit is Bit + 1,
    decode(Rest, NextBit, RestDecimal),
    (
        Head == '1' -> Decimal is 2^Bit + RestDecimal;
        Head == '0' -> Decimal is RestDecimal
    ).
    
