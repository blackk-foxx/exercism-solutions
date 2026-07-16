value(Colors, Value) :-
    [First, Second | Rest] = Colors,
    maplist(color_code, [First, Second], Digits),
    reverse(Digits, ReversedDigits),
    combined_value(ReversedDigits, Value).

combined_value([], 0).
combined_value([LeastDigit | Tail], Value) :-
    combined_value(Tail, TailValue),
    Value is TailValue * 10 + LeastDigit.

color_code(Color, Code) :-
    colors(AllColors),
    nth0(Code, AllColors, Color).

colors(Colors) :-
    Colors = [
        "black", "brown", "red", "orange", "yellow", 
        "green", "blue", "violet", "grey", "white"
    ].
