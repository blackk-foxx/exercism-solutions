create_clock(Hours, Minutes, Clock) :-
    add_minutes(clock(Hours, Minutes), 0, Clock).

display(clock(Hours, Minutes), Time) :-
    format(string(Time), "~|~`0t~d~2+:~|~`0t~d~2+", [Hours, Minutes]).

add_minutes(clock(H, M), Minutes, NewClock) :-
    NewMinutes is H * 60 + M + Minutes,
    minutes_clock(NewMinutes, NewClock).

subtract_minutes(Clock, Minutes, NewClock) :-
    NegativeMinutes is - Minutes,
    add_minutes(Clock, NegativeMinutes, NewClock).

minutes_clock(Minutes, clock(H, M)) :-
    (
        Minutes >= 0 -> Hours is Minutes // 60
        ; Hours is (Minutes - 59) // 60
    ),
    H is Hours mod 24,
    M is Minutes mod 60.
