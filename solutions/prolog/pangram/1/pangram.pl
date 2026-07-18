is_alpha(Char) :-
    char_type(Char, alpha).

pangram(Sentence) :-
    string_upper(Sentence, UppercaseSentence),
    string_chars(UppercaseSentence, SentenceChars),
    include(is_alpha, SentenceChars, SentenceLetters),
    list_to_set(SentenceLetters, SentenceLetterSet),
    length(SentenceLetterSet, SentenceLetterSetLength),
    SentenceLetterSetLength =:= 26.
   