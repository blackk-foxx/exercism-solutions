say(0, "zero").
say(1, "one").
say(2, "two").
say(3, "three").
say(4, "four").
say(5, "five").
say(6, "six").
say(7, "seven").
say(8, "eight").
say(9, "nine").
say(10, "ten").
say(11, "eleven").
say(12, "twelve").
say(13, "thirteen").
say(14, "fourteen").
say(15, "fifteen").
say(16, "sixteen").
say(17, "seventeen").
say(18, "eighteen").
say(19, "nineteen").
say(20, "twenty").
say(30, "thirty").
say(40, "forty").
say(50, "fifty").
say(60, "sixty").
say(70, "seventy").
say(80, "eighty").
say(90, "ninety").

say(N, English) :-
    between(21, 99, N),
    Tens is 10 * (N // 10),
    Ones is N mod 10,
    say(Tens, TensString),
    say_combo([TensString], "-", Ones, English),
    !.

say(N, English) :-
    scale_word(ScaleMin, ScaleMax, ScaleWord),
    between(ScaleMin, ScaleMax, N),
    Quantity is N // ScaleMin,
    Remainder is N mod ScaleMin,
    say(Quantity, QuantityString),
    say_combo([QuantityString, ScaleWord], " ", Remainder, English).

scale_word(100, 999, "hundred").
scale_word(1_000, 999_999, "thousand").
scale_word(1_000_000, 999_999_999, "million").
scale_word(1_000_000_000, 999_999_999_999, "billion").

say_combo(Prefix, Separator, 0, English) :-
    atomics_to_string(Prefix, Separator, English),
    !.
say_combo(Prefix, Separator, Remainder, English):-
    say(Remainder, RemainderString),
    append(Prefix, [RemainderString], Parts),
    atomics_to_string(Parts, Separator, English).
