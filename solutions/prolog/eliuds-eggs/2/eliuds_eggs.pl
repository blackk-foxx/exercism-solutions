egg_count(0, Acc, Acc).
egg_count(EncodedCount, Acc, Count) :-
    RemainingEncodedCount is EncodedCount // 2,
    NewAcc is Acc + EncodedCount mod 2,
    egg_count(RemainingEncodedCount, NewAcc, Count).

egg_count(EncodedCount, Count) :-
    egg_count(EncodedCount, 0, Count).
