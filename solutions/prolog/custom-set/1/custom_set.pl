create_set(Set) :- Set = [].

create_set(Data, Set) :- sort(Data, Set).

add(Value, Set, Added) :-
    in_set(Value, Set), Added = Set,!;
    append(Set, [Value], Unsorted),
    create_set(Unsorted, Added).

is_empty(Set) :- length(Set, 0).

in_set(Value, Set) :- member(Value, Set).

set_has(Set, Value) :- in_set(Value, Set).

is_subset(Set1, Set2) :- maplist(set_has(Set2), Set1).

is_disjoint(Set1, Set2) :-
    include(set_has(Set1), Set2, Inc1),
    include(set_has(Set2), Set1, Inc2),
    is_empty(Inc1), is_empty(Inc2).

difference(Set1, Set2, Difference) :-
    exclude(set_has(Set2), Set1, Difference).

intersection(Set1, Set2, Intersection) :-
    include(set_has(Set2), Set1, Intersection).

union(Set1, Set2, Union) :-
    append(Set1, Set2, Unsorted),
    create_set(Unsorted, Union).
