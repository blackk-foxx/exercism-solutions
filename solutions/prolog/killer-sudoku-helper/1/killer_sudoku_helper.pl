combinations(Size, Sum, Exclude, Combinations) :-
    numlist(1, 9, Digits),
    findall(
        List, (
          sub_set(Digits, List),
          length(List, Size),
          sumlist(List, Sum),
          intersection(List, Exclude, [])
        ),
        Combinations
    ).    

sub_set([], []).

sub_set([Head|Tail], [Head|SubTail]) :-
    sub_set(Tail, SubTail).

sub_set([_|Tail], SubTail) :-
    sub_set(Tail, SubTail).
