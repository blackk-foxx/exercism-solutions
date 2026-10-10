garden(Garden, Child, Plants) :-
    string_chars(Garden, GardenChars),
    append(Row1, ['\n' | Row2], GardenChars),
    students(Students),
    nth0(Index, Students, Child),
    CupIndex is Index * 2,
    length(Prefix1, CupIndex),
    length(Prefix2, CupIndex),
    append(Prefix1, [C1, C2 | _], Row1),
    append(Prefix2, [C3, C4 | _], Row2),
    maplist(char_plant, [C1, C2, C3, C4], Plants).

students([alice, bob, charlie, david, eve, fred, ginny, harriet, ileana, joseph, kincaid, larry]).

char_plant('G', grass).
char_plant('C', clover).
char_plant('R', radishes).
char_plant('V', violets).
