anagram(Word, Candidates, Anagrams) :-
    include(is_anagram(Word), Candidates, Anagrams).

is_anagram(Word, Candidate) :-
    string_upper(Word, UpperWord),
    string_upper(Candidate, UpperCandidate),
    UpperWord \== UpperCandidate,
    msort_chars(UpperCandidate, Sorted),
    msort_chars(UpperWord, Sorted).

msort_chars(Word, Sorted) :-
    string_chars(Word, Chars),
    msort(Chars, Sorted).
