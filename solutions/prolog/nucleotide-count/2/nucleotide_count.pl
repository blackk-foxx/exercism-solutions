nucleotide_count(String, [('A', A), ('C', C), ('G', G), ('T', T)]) :-
    string_chars(String, Chars),
    nucleotide_count(Chars, (0, 0, 0, 0), (A, C, G, T)).

nucleotide_count([], Counts, Counts).

nucleotide_count([C|Cs], CountsIn, CountsOut) :-
    bump_counts(C, CountsIn, CountsNext),
    nucleotide_count(Cs, CountsNext, CountsOut).
    
bump_counts('A', (AIn, CIn, GIn, TIn), (AOut, CIn, GIn, TIn)) :-
    AOut is AIn + 1.
bump_counts('C', (AIn, CIn, GIn, TIn), (AIn, COut, GIn, TIn)) :-
    COut is CIn + 1.
bump_counts('G', (AIn, CIn, GIn, TIn), (AIn, CIn, GOut, TIn)) :-
    GOut is GIn + 1.
bump_counts('T', (AIn, CIn, GIn, TIn), (AIn, CIn, GIn, TOut)) :-
    TOut is TIn + 1.
