sum(0, 0).
sum(N, Result) :- 
    PrevN is N - 1,
    sum(PrevN, PrevSum),
    Result is PrevSum + N.

square_of_sum(N, Result) :-
    sum(N, Sum),
    Result is Sum^2.

sum_of_squares(0, 0).
sum_of_squares(N, Result) :-
    PrevN is N - 1,
    sum_of_squares(PrevN, PrevSum),
    Result is PrevSum + N^2.

difference(N, Result) :-
    square_of_sum(N, SquareOfSum),
    sum_of_squares(N, SumOfSquares),
    Result is SquareOfSum - SumOfSquares.
