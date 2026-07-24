has_bit(Value, Bit) :- Value /\ 2^Bit =:= 2^Bit.

allergic_to(Score, eggs) :- has_bit(Score, 0).
allergic_to(Score, peanuts) :- has_bit(Score, 1).
allergic_to(Score, shellfish) :- has_bit(Score, 2).
allergic_to(Score, strawberries) :- has_bit(Score, 3).
allergic_to(Score, tomatoes) :- has_bit(Score, 4).
allergic_to(Score, chocolate) :- has_bit(Score, 5).
allergic_to(Score, pollen) :- has_bit(Score, 6).
allergic_to(Score, cats) :- has_bit(Score, 7).

allergies(Score, Allergies) :-
    findall(X, allergic_to(Score, X), Allergies).
