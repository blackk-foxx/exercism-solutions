squared(N, Result) :- Result is N^2.

square_of_sum(N, Result) :- 
    numlist(1, N, List),
    sum_list(List, Sum),
    squared(Sum, Result).

sum_of_squares(N, Result) :-
    numlist(1, N, List),
    maplist(squared, List, ListOfSquares),
    sum_list(ListOfSquares, Result).

difference(N, Result) :-
    square_of_sum(N, SquareOfSum),
    sum_of_squares(N, SumOfSquares),
    Result is SquareOfSum - SumOfSquares.
