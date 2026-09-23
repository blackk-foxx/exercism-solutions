letter_num_pair(Num, Letter, Atom-Num) :- 
    string_lower(Letter, Lower),
    atom_string(Atom, Lower).

transform([], Acc, Result) :-
    sort(Acc, Result).

transform([Num-Letters|Tail], Acc, LetterScores) :-
    maplist(letter_num_pair(Num), Letters, HeadLetterScores),
    append(HeadLetterScores, Acc, NewAcc),
    transform(Tail, NewAcc, LetterScores).

transform(ScoreLetters, LetterScores) :-
    transform(ScoreLetters, [], LetterScores).
