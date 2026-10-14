translate("", []).
translate(Rna, []) :-
    first_codon(Rna, Codon),
    stop_codon(Codon),
    !.
translate(Rna, [Acid | TailAcids]) :-
    first_codon(Rna, Codon),
    codon_acid(Codon, Acid),
    string_concat(Codon, RnaTail, Rna),
    translate(RnaTail, TailAcids).

first_codon(Rna, Codon) :- sub_string(Rna, 0, 3, _, Codon).

codon_acid("AUG", "Methionine").
codon_acid(Codon, "Phenylalanine") :- member(Codon, ["UUU", "UUC"]).
codon_acid(Codon, "Leucine") :- member(Codon, ["UUA", "UUG"]).
codon_acid(Codon, "Serine") :-
    member(Codon, ["UCU", "UCC", "UCA", "UCG"]).
codon_acid(Codon, "Tyrosine") :- member(Codon, ["UAU", "UAC"]).
codon_acid(Codon, "Cysteine") :- member(Codon, ["UGU", "UGC"]).
codon_acid("UGG", "Tryptophan").

stop_codon(Codon) :- member(Codon, ["UAA", "UAG", "UGA"]). 
