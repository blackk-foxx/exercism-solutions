rotate(Plaintext, Amount, Ciphertext) :-
    string_chars(Plaintext, Chars),
    maplist(rotate_char(Amount), Chars, RotatedChars),
    atomics_to_string(RotatedChars, Ciphertext).

rotate_char(Amount, CharIn, CharOut) :-
    base_code(CharIn, BaseCode),
    char_code(CharIn, Code),
    NewCode is BaseCode + (Code - BaseCode + Amount) mod 26,
    char_code(CharOut, NewCode),
    !.

rotate_char(_, Char, Char).

base_code(Char, BaseCode) :-
    base_char(Char, BaseChar),
    char_code(BaseChar, BaseCode).

base_char(Char, BaseChar) :-
    char_type(Char, upper), BaseChar = 'A';
    char_type(Char, lower), BaseChar = 'a'.
