latest(Scores, Latest) :- last(Scores, Latest).

personal_best(Scores, Best) :- max_list(Scores, Best).

personal_top_three(Scores, TopThree) :-
    sort(0, @>=, Scores, SortedScores),
    take(3, SortedScores, TopThree).

take(0, _, []).
take(_, [], []).
take(N, [Head | Tail], [Head | TailFront]) :- 
    M is N - 1, take(M, Tail, TailFront).
