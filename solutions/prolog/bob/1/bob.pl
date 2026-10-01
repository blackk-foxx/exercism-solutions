hey(Sentence, "Calm down, I know what I'm doing!") :-
    is_question(Sentence), is_yelling(Sentence), !.
hey(Sentence, "Sure.") :- is_question(Sentence), !.
hey(Sentence, "Whoa, chill out!") :- is_yelling(Sentence), !.
hey(Sentence, "Fine. Be that way!") :- is_silence(Sentence), !.
hey(_, "Whatever.").

is_question(Sentence) :-
    normalize_space(string(Trimmed), Sentence),
    sub_string(Trimmed, _, _, 0, "?").

is_yelling(Sentence) :-
    string_chars(Sentence, Chars),
    include(is_alpha, Chars, AlphaChars),
    \+ length(AlphaChars, 0),
    maplist(is_upper, AlphaChars).

is_silence(Sentence) :-
    string_chars(Sentence, Chars),
    include(is_alphanum, Chars, AlphaNumChars),
    length(AlphaNumChars, 0).

is_alphanum(Char) :- is_alpha(Char); char_type(Char, digit).
