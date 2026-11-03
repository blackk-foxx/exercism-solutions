label(Colors, Label) :-
    maplist(color_value, Colors, [Tens, Ones, Exp | _]),
    Resistance is (Tens * 10 + Ones) * 10 ^ Exp,
    resistance_label(Resistance, Label).

color_value("black", 0).
color_value("brown", 1).
color_value("red", 2).
color_value("orange", 3).
color_value("yellow", 4).
color_value("green", 5).
color_value("blue", 6).
color_value("violet", 7).
color_value("grey", 8).
color_value("white", 9).

resistance_label(0, "0 ohms") :- !.
resistance_label(Resistance, Label) :-
    Order is floor(log10(Resistance)) // 3,
    Quantity is Resistance // (1000 ^ Order),
    order_prefix(Order, Prefix),
    format(string(Label), "~w ~wohms", [Quantity, Prefix]).

order_prefix(0, "").
order_prefix(1, "kilo").
order_prefix(2, "mega").
order_prefix(3, "giga").
