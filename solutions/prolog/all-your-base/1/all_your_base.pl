rebase(InputBase, InputDigits, OutputBase, OutputDigits) :-
    valid(InputBase, InputDigits, OutputBase),
    base_digits_value(InputBase, InputDigits, Value),
    value_base_digits(Value, OutputBase, OutputDigits).

valid(InputBase, InputDigits, OutputBase) :-
    InputBase > 1,
    OutputBase > 1,
    MaxInputDigit is InputBase - 1,
    maplist(between(0, MaxInputDigit), InputDigits).

base_digits_value(Base, Digits, Value) :-
    foldl(accumulate(Base), Digits, 0, Value).

accumulate(Base, Digit, AccIn, AccOut) :-
    AccOut is AccIn * Base + Digit.

value_base_digits(0, _, [0]) :- !.
value_base_digits(Value, Base, Digits) :-
    value_base_digits(Value, Base, [], Digits).

value_base_digits(0, _, Acc, Acc) :- !.
value_base_digits(Value, Base, Acc, Digits) :-
    Digit is Value mod Base,
    NextValue is Value // Base,
    value_base_digits(NextValue, Base, [Digit | Acc], Digits).
