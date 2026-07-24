square_root(Number, SquareRoot) :-
    find_square_root(1, Number, Number, SquareRoot).

find_square_root(Low, High, Number, Mid) :-
    Mid is (Low + High) // 2, 
    Mid^2 =:= Number.

find_square_root(Low, High, Number, SquareRoot) :-
    Mid is (Low + High) // 2, 
    Mid^2 < Number,
    find_square_root(Mid, High, Number, SquareRoot).

find_square_root(Low, High, Number, SquareRoot) :-
    Mid is (Low + High) // 2,
    Mid^2 > Number,
    find_square_root(Low, Mid, Number, SquareRoot).
