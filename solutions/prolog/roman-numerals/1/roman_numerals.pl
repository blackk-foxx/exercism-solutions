convert(0, "").
convert(N, Numeral) :-
    N < 4 -> convert(1, "I", N, Numeral),!;
    N < 5 -> convert(4, "IV", N, Numeral),!;
    N < 9 -> convert(5, "V", N, Numeral),!;
    N < 10 -> convert(9, "IX", N, Numeral),!;
    N < 40 -> convert(10, "X", N, Numeral),!;
    N < 50 -> convert(40, "XL", N, Numeral),!;
    N < 90 -> convert(50, "L", N, Numeral),!;
    N < 100 -> convert(90, "XC", N, Numeral),!;
    N < 400 -> convert(100, "C", N, Numeral),!;
    N < 500 -> convert(400, "CD", N, Numeral),!;
    N < 900 -> convert(500, "D", N, Numeral),!;
    N < 1000 -> convert(900, "CM", N, Numeral),!;
    N < 4000 -> convert(1000, "M", N, Numeral),!.
    
convert(Unit, UnitNumeral, Value, Numeral) :-
    TailValue is Value - Unit,
    convert(TailValue, Tail),
    string_concat(UnitNumeral, Tail, Numeral).
