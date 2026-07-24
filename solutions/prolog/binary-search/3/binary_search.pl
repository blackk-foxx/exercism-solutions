find(List, Value, Index) :-
    length(List, Length),
    find_in_range(0, Length, List, Value, Index).

find_in_range(Low, High, List, Value, Index) :-
    Low < High,
    Mid is (Low + High) // 2,
    nth0(Mid, List, ValueAtMid),
    (
        Value == ValueAtMid -> Index is Mid;
        Value < ValueAtMid ->
            find_in_range(Low, Mid, List, Value, Index);
        find_in_range(Mid + 1, High, List, Value, Index)
    ).
        