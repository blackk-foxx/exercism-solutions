value(Colors, Value) :-
    [First, Second | _] = Colors,
    maplist(color_code, [First, Second], Digits),
    foldl(append_digit, Digits, 0, Value).

append_digit(Digit, Acc, Value) :- Value is Acc * 10 + Digit. 

color_code(Color, Code) :-
    colors(AllColors),
    nth0(Code, AllColors, Color).

colors(Colors) :-
    Colors = [
        "black", "brown", "red", "orange", "yellow", 
        "green", "blue", "violet", "grey", "white"
    ].
