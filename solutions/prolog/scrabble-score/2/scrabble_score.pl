score(Word, Score) :-
    string_upper(Word, UpperWord),
    string_chars(UpperWord, Chars),
    foldl(add_letter_score, Chars, 0, Score).

add_letter_score(Letter, AccIn, AccOut) :-
    letter_score(Letter, LetterScore),
    AccOut is AccIn + LetterScore.

letter_score(Letter, 1) :- member_string(Letter, "AEIOULNRST").
letter_score(Letter, 2) :- member_string(Letter, "DG").
letter_score(Letter, 3) :- member_string(Letter, "BCMP").
letter_score(Letter, 4) :- member_string(Letter, "FHVWY").
letter_score(Letter, 5) :- member_string(Letter, "K").
letter_score(Letter, 8) :- member_string(Letter, "JX").
letter_score(Letter, 10) :- member_string(Letter, "QZ").

member_string(Letter, String) :-
    string_chars(String, Chars),
    member(Letter, Chars).
