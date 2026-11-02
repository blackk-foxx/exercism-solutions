smallest(MinFactor, MaxFactor, Product, Factors) :-
    products_with_factors(MinFactor, MaxFactor, ProductsWithFactors),
    nth1(1, ProductsWithFactors, (Product, _)),
    convlist(second_for_matching_first(Product), ProductsWithFactors, Factors).

largest(MinFactor, MaxFactor, Product, Factors) :-
    products_with_factors(MinFactor, MaxFactor, ProductsWithFactors),
    last(ProductsWithFactors, (Product, _)),
    convlist(second_for_matching_first(Product), ProductsWithFactors, Factors).

products_with_factors(MinFactor, MaxFactor, ProductsWithFactors) :-
    setof(
            (P, F1-F2),
            (
                between(MinFactor, MaxFactor, F1),
                between(F1, MaxFactor, F2),
                P is F1 * F2,
                is_palindrome(P)
            ),
            ProductsWithFactors
        ).

second_for_matching_first(A, (A, B), B).

is_palindrome(N) :-
    number_chars(N, Digits),
    reverse(Digits, Digits).
