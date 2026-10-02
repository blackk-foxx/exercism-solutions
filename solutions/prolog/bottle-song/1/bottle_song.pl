recite(Start, [FirstLine, FirstLine, Middle, LastLine]) :-
    Next is Start - 1,
    numbered_object(Start, StartObject),
    numbered_object(Next, NextObject),
    string_lower(NextObject, NextObjectLowercase),
    format(string(FirstLine), "~w hanging on the wall,", [StartObject]),
    Middle = "And if one green bottle should accidentally fall,",
    format(string(LastLine), "There'll be ~w hanging on the wall.", [NextObjectLowercase]).
    
recite(Start, Count, Lyrics) :-
    count_down(Start, Count, Numbers),
    maplist(recite, Numbers, LyricsLists),
    intersperse(LyricsLists, "", DelimitedLists),
    flatten(DelimitedLists, Lyrics).

count_down(N, Count, List) :-
    Min is N - Count + 1,
    numlist(Min, N, IncreasingNumbers),
    reverse(IncreasingNumbers, List).

intersperse([X], _, [X]).
intersperse([X | Xs], Separator, Result) :-
    intersperse(Xs, Separator, Rest),
    append([X, Separator], Rest, Result).
    
numbered_object(Number, Phrase) :-
    (Number == 1 -> Suffix = ""; Suffix = "s"),
    number_word(Number, NumberWord),
    atomics_to_string([NumberWord, " green bottle", Suffix], Phrase).

number_word(10, "Ten").
number_word(9, "Nine").
number_word(8, "Eight").
number_word(7, "Seven").
number_word(6, "Six").
number_word(5, "Five").
number_word(4, "Four").
number_word(3, "Three").
number_word(2, "Two").
number_word(1, "One").
number_word(0, "No").