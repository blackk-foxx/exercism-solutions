commands(Encoded, Commands) :-
    decimal_to_bit_positions(Encoded, Positions),
    maplist(gesture, Positions, RawCommands),
    finalize(RawCommands, Commands).

gesture(0, wink).
gesture(1, double_blink).
gesture(2, close_your_eyes).
gesture(3, jump).
gesture(4, reverse).

finalize([reverse | Remaining], Remaining).
finalize(RevCommands, Commands) :- reverse(RevCommands, Commands).

decimal_to_bit_positions(Decimal, Positions) :-
    decimal_to_bit_positions(Decimal, 0, [], Positions).

decimal_to_bit_positions(0, _, Acc, Acc) :- !.
decimal_to_bit_positions(Decimal, Pos, Acc, AccOut) :-
    Bit is Decimal mod 2,
    NextDecimal is Decimal // 2,
    NextPos is Pos + 1,
    (Bit = 1 -> NextAcc = [Pos | Acc]; NextAcc = Acc),
    decimal_to_bit_positions(NextDecimal, NextPos, NextAcc, AccOut).
