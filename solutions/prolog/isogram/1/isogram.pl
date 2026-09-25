is_alpha(Char) :- char_type(Char, alpha).

string_normalized_chars(String, NormalizedChars) :-
    string_lower(String, LowerString),
    string_chars(LowerString, Chars),
    include(is_alpha, Chars, NormalizedChars).

isogram(Phrase) :-
    string_normalized_chars(Phrase, CleanChars),
    is_set(CleanChars).
