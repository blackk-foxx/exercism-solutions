largest_product(Input, Span, Product) :-
    string_digits(Input, Digits),
    Span >= 0,
    sublist_products(Digits, Span, Products),
    max_list(Products, Product).

string_digits(String, Digits) :-
    string_chars(String, Chars),
    maplist(char_number, Chars, Digits).

char_number(Char, Number) :- 
    char_type(Char, digit),
    number_chars(Number, [Char]).

sublist_products(List, Span, [Product]) :-
    length(List, Span),
    product_list(List, Product).

sublist_products([X | Remaining], Span, Products) :-
    prefix(Prefix, Span, [X | Remaining]),
    product_list(Prefix, PrefixProduct),
    sublist_products(Remaining, Span, RemainingProducts),
    append([PrefixProduct], RemainingProducts, Products).

product_list([A], A) :- !.
product_list([A | Tail], Result) :-
    product_list(Tail, TailProduct),
    Result is A * TailProduct.

prefix(Prefix, Length, List) :-
    length(Prefix, Length),
    append(Prefix, _, List).
