egg_count_acc(0, Acc, Acc).
egg_count_acc(EncodedCount, Acc, Count) :-
    RemainingEncodedCount is EncodedCount // 2,
    NewAcc is Acc + EncodedCount mod 2,
    egg_count_acc(RemainingEncodedCount, NewAcc, Count).

egg_count(EncodedCount, Count) :-
    egg_count_acc(EncodedCount, 0, Count).
