smallest(MinFactor, MaxFactor, Product, Factors) :-
    MinProduct is MinFactor^2,
    MaxProduct is MaxFactor^2,
    between(MinProduct, MaxProduct, Product),
    is_palindrome(Product),
    product_factors(Product, MinFactor, MaxFactor, Factors),
    Factors \= [],
    !.

largest(MinFactor, MaxFactor, Product, Factors) :-
    MinProduct is MinFactor^2,
    MaxProduct is MaxFactor^2,
    between_reversed(MaxProduct, MinProduct, Product),
    is_palindrome(Product),
    product_factors(Product, MinFactor, MaxFactor, Factors),
    Factors \= [],
    !.

between_reversed(High, Low, High) :-
    High >= Low.
between_reversed(High, Low, Value) :-
    High > Low,
    NextHigh is High - 1,
    between_reversed(NextHigh, Low, Value).

is_palindrome(N) :-
    number_chars(N, Digits),
    reverse(Digits, Digits).

product_factors(Product, MinFactor, MaxFactor, Factors) :-
    findall(A-B, (
            between(MinFactor, MaxFactor, A),
            between(A, MaxFactor, B),
            Product is A * B
        ),
        Factors
    ).
