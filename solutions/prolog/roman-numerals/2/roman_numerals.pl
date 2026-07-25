numeral(1, 4, "I").
numeral(4, 5, "IV").
numeral(5, 9, "V").
numeral(9, 10, "IX").
numeral(10, 40, "X").
numeral(40, 50, "XL").
numeral(50, 90, "L").
numeral(90, 100, "XC").
numeral(100, 400, "C").
numeral(400, 500, "CD").
numeral(500, 900, "D").
numeral(900, 1000, "CM").
numeral(1000, 4000, "M").

convert(0, "").
convert(N, Numeral) :- 
    numeral(Value, UpperBound, Head), 
    N >= Value, 
    N < UpperBound,
    TailValue is N - Value,
    convert(TailValue, Tail),
    string_concat(Head, Tail, Numeral),!.
