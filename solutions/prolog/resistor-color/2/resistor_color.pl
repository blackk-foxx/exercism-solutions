colors(Colors) :-
    Colors = [
        "black", "brown", "red", "orange", "yellow", 
        "green", "blue", "violet", "grey", "white"
    ].

color_code(Color, Code) :-
    colors(AllColors),
    nth0(Code, AllColors, Color).
