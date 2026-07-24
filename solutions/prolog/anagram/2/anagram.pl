anagram(Word, Candidates, Anagrams) :-
    include(is_anagram(Word), Candidates, Anagrams).

is_anagram(Word, Candidate) :-
    string_upper_chars(Word, UpperWordChars),
    string_upper_chars(Candidate, UpperCandidateChars),
    UpperWordChars \== UpperCandidateChars,
    permutation(UpperCandidateChars, UpperWordChars).

string_upper_chars(Word, Chars) :-
    string_upper(Word, UpperWord),
    string_chars(UpperWord, Chars).
