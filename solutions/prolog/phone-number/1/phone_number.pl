:- use_module(library(dcg/basics)).

cleanup(Input, Cleaned) :-
    string_codes(Input, InputCodes),
    exclude(is_space, InputCodes, NonblankCodes),
    phrase(phone_number(AreaCode, Prefix, LineNumber), NonblankCodes),
    flatten([AreaCode, Prefix, LineNumber], Codes),
    string_codes(Cleaned, Codes).

phone_number(AreaCode, Prefix, LineNumber) -->
    country_code,
    ( "(", area_code(AreaCode), ")" ; area_code(AreaCode) ), 
    separator, 
    prefix(Prefix), 
    separator, 
    line_number(LineNumber).

country_code --> ""; "1"; "+1".

separator --> ""; "."; "-".

area_code(AreaCode) --> restricted_code(AreaCode).

prefix(Prefix) --> restricted_code(Prefix).

line_number([A, B, C, D]) --> digit(A), digit(B), digit(C), digit(D).

restricted_code([First, Mid, Last]) --> 
    digit(First), digit(Mid), digit(Last),
    { between(0'2, 0'9, First) }.
