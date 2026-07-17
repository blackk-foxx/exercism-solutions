score(Word, Score) :-
    string_upper(Word, UpperWord),
    string_chars(UpperWord, Chars),
    foldl(add_letter_score, Chars, 0, Score).

add_letter_score(Letter, AccIn, AccOut) :-
    letter_score(Letter, LetterScore),
    AccOut is AccIn + LetterScore.

letter_score(Letter, Score) :-
    member_string(Letter, "AEIOULNRST"), Score is 1;
    member_string(Letter, "DG"), Score is 2;
    member_string(Letter, "BCMP"), Score is 3;
    member_string(Letter, "FHVWY"), Score is 4;
    Letter = 'K', Score is 5;
    member_string(Letter, "JX"), Score is 8;
    member_string(Letter, "QZ"), Score is 10.

member_string(Letter, String) :-
    string_chars(String, Chars),
    member(Letter, Chars).
