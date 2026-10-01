abbreviate(Sentence, Acronym) :-
    split_string(Sentence, " -", "", Parts),
    exclude(==(""), Parts, Words),
    maplist(first_alpha_as_upper, Words, FirstChars),
    atomics_to_string(FirstChars, Acronym).

first_alpha_as_upper(InputString, FirstAlphaAsUpper) :-
    string_chars(InputString, CharList),
    include(is_alpha, CharList, [FirstAlpha | _]),
    upcase_atom(FirstAlpha, FirstAlphaAsUpper).
