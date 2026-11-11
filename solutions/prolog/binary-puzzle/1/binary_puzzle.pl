:- use_module(library(clpfd)).

binary_puzzle(Rows) :-
    
    transpose(Rows, Columns),

    % Rule 1. Every cell contains 0 or 1
    append(Rows, Vs), Vs ins 0..1,

    % Rule 2. No more than two adjacent digits are equal
    maplist(max_two_equal_adjacent_digits, Rows),
    maplist(max_two_equal_adjacent_digits, Columns),

    % Rule 3. Each row and each column contains equal numbers of 0s and 1s
    maplist(sum_is_half_its_length, Rows),
    maplist(sum_is_half_its_length, Columns),

    % Rule 4. Each row and column is unique
    all_lists_unique(Rows),
    all_lists_unique(Columns).

max_two_equal_adjacent_digits(List) :- length(List, Length), Length < 3, !.
max_two_equal_adjacent_digits(List) :-
    length(Window, 3),
    append(Window, _, List),
    sum(Window, #=, Sum), Sum in 1..2,
    List = [_|Tail],
    max_two_equal_adjacent_digits(Tail).

sum_is_half_its_length(List) :-
    length(List, Length),
    HalfLength #= Length // 2,
    sum(List, #=, HalfLength).

all_lists_unique(ListOfLists) :-
    sort(ListOfLists, Sorted),
    same_length(ListOfLists, Sorted).
