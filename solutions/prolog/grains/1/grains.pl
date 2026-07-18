square(SquareNumber, Value) :-
    between(1, 64, SquareNumber),
    Value is 2^(SquareNumber - 1).

total(Value) :- 
    numlist(1, 64, Squares),
    maplist(square, Squares, SquareValues),
    sumlist(SquareValues, Value).
