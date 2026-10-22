encode(Plaintext, Ciphertext) :-
    string_clean_codes(Plaintext, CleanCodes),
    maplist(encode_code, CleanCodes, CipherCodes),
    string_codes(UnchunkedCiphertext, CipherCodes),
    chunk(UnchunkedCiphertext, Ciphertext).

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

encode_code(Code, Code) :- is_numeric(Code), !.
encode_code(Code, CipherCode) :- CipherCode is 25 + 2 * 0'a - Code.

chunk(String, String) :- string_length(String, Length), Length =< 5, !.
chunk(String, ChunkedString) :-
    sub_string(String, 0, 5, _, Chunk),
    sub_string(String, 5, _, 0, Remainder),
    chunk(Remainder, ChunkedRemainder),
    format(string(ChunkedString), "~w ~w", [Chunk, ChunkedRemainder]).
