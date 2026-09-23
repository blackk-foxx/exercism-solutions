next_step(N, NextN) :- 0 is N mod 2, NextN is (N // 2),!.
next_step(N, NextN) :- NextN is (N * 3 + 1).

collatz_steps(1, Acc, Acc).
collatz_steps(N, Acc, Steps) :-
    N > 1,
    next_step(N, NextN),
    NewAcc is 1 + Acc,
    collatz_steps(NextN, NewAcc, Steps).

collatz_steps(N, Steps) :- collatz_steps(N, 0, Steps).
