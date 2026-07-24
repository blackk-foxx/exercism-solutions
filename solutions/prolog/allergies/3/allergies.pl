allergies(Score, Allergies) :-
    findall(X, allergic_to(Score, X), Allergies).

allergic_to(Score, Allergen) :-
    bit(Allergen, Bit),
    has_bit(Score, Bit).

bit(eggs, 0).
bit(peanuts, 1).
bit(shellfish, 2).
bit(strawberries, 3).
bit(tomatoes, 4).
bit(chocolate, 5).
bit(pollen, 6).
bit(cats, 7).

has_bit(Value, Bit) :- Value /\ 2^Bit =:= 2^Bit.
