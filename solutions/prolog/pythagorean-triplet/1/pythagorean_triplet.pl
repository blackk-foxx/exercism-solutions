triplets(Sum, Triplets) :-
    Max is Sum // 2,
    findall(
        (A, B, C),
        (
            between(1, Max, A),
            MinB is A + 1,
            between(MinB, Max, B),
            MinC is B + 1,
            between(MinC, Max, C),
            A^2 + B^2 =:= C^2,
            A + B + C =:= Sum
        ),
        Triplets
    ).
