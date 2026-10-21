encode(Plaintext, Ciphertext) :-
    string_clean_codes(Plaintext, CleanCodes),
    maplist(encode_code, CleanCodes, CipherCodes),
    separate_groups(CipherCodes, GroupedCipherCodes),
    string_codes(Ciphertext, GroupedCipherCodes).

decode(Ciphertext, Plaintext) :-
    string_clean_codes(Ciphertext, CleanCodes),
    maplist(encode_code, CleanCodes, PlainCodes),
    string_codes(Plaintext, PlainCodes).

string_clean_codes(String, CleanCodes) :-
    string_lower(String, Lower),
    string_codes(Lower, Codes),
    include(is_alphanum, Codes, CleanCodes).

is_alphanum(Code) :- is_alpha(Code); is_numeric(Code).

is_numeric(Code) :- between(0'0, 0'9, Code).

separate_groups(Codes, GroupedCodes) :-
    separate_groups(Codes, [], GroupedCodes).

separate_groups(Tail, Acc, GroupedCodes) :-
    length(Tail, Length),
    Length =< 5,
    append(Acc, Tail, GroupedCodes),
    !.
separate_groups([C1, C2, C3, C4, C5 | Tail], Acc, GroupedCodes) :-
    append(Acc, [C1, C2, C3, C4, C5, (0' )], NewAcc),
    separate_groups(Tail, NewAcc, GroupedCodes).
    
encode_code(Code, Code) :- is_numeric(Code), !.
encode_code(Code, CipherCode) :- CipherCode is 25 + 2 * 0'a - Code.
