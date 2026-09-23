next_step(N, NextN) :-
    (0 is N mod 2 -> NextN is (N // 2); NextN is (N * 3 + 1)).

collatz_steps(1, 0).
collatz_steps(N, Steps) :-
    N > 1,
    next_step(N, NextN),
    collatz_steps(NextN, NextSteps),
    Steps is 1 + NextSteps.
