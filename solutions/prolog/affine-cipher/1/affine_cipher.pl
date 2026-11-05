encode(Plaintext, A, B, Ciphertext) :-
    mod_inverse(A, 26, _),
    normalize_codes(Plaintext, PlainCodes),
    maplist(encode_code(A, B), PlainCodes, CipherCodes),
    group(CipherCodes, GroupedCipherCodes),
    string_codes(Ciphertext, GroupedCipherCodes).

decode(Ciphertext, A, B, Plaintext) :-
    mod_inverse(A, 26, X),
    normalize_codes(Ciphertext, CipherCodes),
    maplist(decode_code(X, B), CipherCodes, PlainCodes),
    string_codes(Plaintext, PlainCodes).

normalize_codes(Text, NormalizedCodes) :-
    string_lower(Text, LowercaseText),
    string_codes(LowercaseText, Codes),
    include(is_alphanum, Codes, NormalizedCodes).

encode_code(_, _, Code, Code) :- is_digit(Code), !.
encode_code(A, B, Code, EncodedCode) :-
    Index is Code - 0'a,
    EncodedIndex is (A * Index + B) mod 26,
    EncodedCode is EncodedIndex + 0'a.

decode_code(_, _, Code, Code) :- is_digit(Code), !.
decode_code(X, B, Code, DecodedCode) :-
    Index is Code - 0'a,
    DecodedIndex is X * (Index - B) mod 26,
    DecodedCode is DecodedIndex + 0'a.

% mod_inverse(+A, +M, -X)
% Finds X such that (A * X) mod M =:= 1.
mod_inverse(A, M, X) :-
    ext_gcd(A, M, X0, _, 1), !, % Ensure GCD is 1
    X is (X0 mod M + M) mod M.   % Ensure a positive result

% ext_gcd(+A, +B, -X, -Y, -Gcd)
% Extended Euclidean Algorithm implementation
ext_gcd(0, B, 0, 1, B) :- !.
ext_gcd(A, B, X, Y, Gcd) :-
    A > 0,
    Quotient is B // A,
    Remainder is B mod A,
    ext_gcd(Remainder, A, X1, Y1, Gcd),
    X is Y1 - Quotient * X1,
    Y is X1.

group(Codes, Codes) :- length(Codes, Length), Length =< 5, !.
group(Codes, GroupedCodes) :-
    length(Prefix, 5),
    append(Prefix, Tail, Codes),
    group(Tail, GroupedTail),
    append(Prefix, [0' | GroupedTail], GroupedCodes).

is_alphanum(Code) :-
    is_alpha(Code); is_digit(Code).

is_digit(Code) :- between(0'0, 0'9, Code).
