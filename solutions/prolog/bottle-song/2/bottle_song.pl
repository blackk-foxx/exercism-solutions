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
    WordForNumber = ["No", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"],
    nth0(Number, WordForNumber, NumberWord),
    format(string(Phrase), "~w green bottle~w", [NumberWord, Suffix]).
