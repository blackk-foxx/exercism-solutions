binary(String, Decimal) :-
    string_chars(String, Chars),
    chars_binary(Chars, Decimal).

chars_binary([], 0).

chars_binary(['0' | Rest], Decimal) :- 
    chars_binary(Rest, Decimal).

chars_binary(['1' | Rest], Decimal) :-
    chars_binary(Rest, RestDecimal),
    length(Rest, Power),
    Decimal is 2^Power + RestDecimal.    
