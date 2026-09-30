slices(Input, Size, Slices) :-
    string_chars(Input, Chars),
    valid_size(Chars, Size),
	findall(L, sublist(Chars, Size, L), SlicesAsLists),
    maplist(atomics_to_string, SlicesAsLists, Slices).

valid_size(List, Size) :-
    0 < Size,
    length(List, Length),
    Size =< Length.

sublist(List, Size, SubList):- 
    append(Prefix, _, List),
    append(_, SubList, Prefix),
    length(SubList, Size).
