largest_product(Input, Span, Product) :-
    string_digits(Input, Digits),
    series(Digits, Span, Series),
    maplist(product_list, Series, Products),
    max_list(Products, Product).

string_digits(String, Digits) :-
    string_chars(String, Chars),
    maplist(char_number, Chars, Digits).

char_number(Char, Number) :- 
    char_type(Char, digit),
    number_chars(Number, [Char]).

series(Digits, Span, Series) :-
    Span >= 0,
    length(Sublist, Span),
    findall(Sublist, sublist(Sublist, Digits), Series).

product_list([A], A) :- !.
product_list([A | Tail], Result) :-
    product_list(Tail, TailProduct),
    Result is A * TailProduct.

sublist(Sublist, List) :-
    append(_, Suffix, List),
    append(Sublist, _, Suffix).
