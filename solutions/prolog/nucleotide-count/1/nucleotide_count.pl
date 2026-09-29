nucleotide_count(String, [('A', ACount), ('C', CCount), ('G', GCount), ('T', TCount)]) :-
    string_chars(String, Chars),
    maplist(is_valid, Chars),
    char_count('A', Chars, ACount),
    char_count('C', Chars, CCount),
    char_count('G', Chars, GCount),
    char_count('T', Chars, TCount).

char_count(Char, Chars, Count) :-
    include(=(Char), Chars, Items), length(Items, Count).
    
is_valid(Char) :- member(Char, ['A', 'C', 'G', 'T']).
