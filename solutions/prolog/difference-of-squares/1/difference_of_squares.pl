number_from([], _).
number_from([H|T], H) :-
    Next is H + 1,
    number_from(T, Next).
    
count(N, List) :-
    length(List, N),
    number_from(List, 1).

squared(N, Result) :- Result is N^2.

square_of_sum(N, Result) :- 
    count(N, List),
    sum_list(List, Sum),
    squared(Sum, Result).

sum_of_squares(N, Result) :-
    count(N, List),
    maplist(squared, List, ListOfSquares),
    sum_list(ListOfSquares, Result).

difference(N, Result) :-
    square_of_sum(N, SquareOfSum),
    sum_of_squares(N, SumOfSquares),
    Result is SquareOfSum - SumOfSquares.
