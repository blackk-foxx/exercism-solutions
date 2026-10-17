commands(Encoded, Commands) :-
    decimal_to_bitmasks(Encoded, Bitmasks),
    maplist(gesture, Bitmasks, RawCommands),
    finalize(RawCommands, Commands).

gesture(0b00001, wink).
gesture(0b00010, double_blink).
gesture(0b00100, close_your_eyes).
gesture(0b01000, jump).
gesture(0b10000, reverse).

finalize([reverse | Remaining], Remaining).
finalize(RevCommands, Commands) :- reverse(RevCommands, Commands).

decimal_to_bitmasks(Decimal, Bitmasks) :-
    decimal_to_bitmasks(Decimal, 1, [], Bitmasks).

decimal_to_bitmasks(N, Mask, Acc, Acc) :- Mask > N, !.
decimal_to_bitmasks(Decimal, Mask, Acc, AccOut) :-
    Result is Decimal /\ Mask,
    NextMask is Mask << 1,
    (Result \= 0 -> NextAcc = [Result | Acc]; NextAcc = Acc),
    decimal_to_bitmasks(Decimal, NextMask, NextAcc, AccOut).
