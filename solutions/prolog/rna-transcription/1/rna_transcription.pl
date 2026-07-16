rna_transcription(Dna, Rna) :-
    string_chars(Dna, DnaChars),
    maplist(complement, DnaChars, RnaChars),
    string_chars(Rna, RnaChars).

complement('G', 'C').
complement('C', 'G').
complement('T', 'A').
complement('A', 'U').
