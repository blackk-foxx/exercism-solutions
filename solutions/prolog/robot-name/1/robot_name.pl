create_robot(Robot) :- Robot = robot(""), reset_name(Robot).

robot_name(robot(Name), Name).

x_reset_name(Robot) :-
    random_between(0'A, 0'Z, C1),
    random_between(0'A, 0'Z, C2),
    random_between(0'0, 0'9, C3),
    random_between(0'0, 0'9, C4),
    random_between(0'0, 0'9, C5),
    string_codes(NewName, [C1, C2, C3, C4, C5]),
    setarg(1, Robot, NewName).

reset_name(Robot) :-
    length(Letters, 2),
    length(Digits, 3),
    maplist(random_between(0'A, 0'Z), Letters),
    maplist(random_between(0'0, 0'9), Digits),
    append(Letters, Digits, NameCodes),
    string_codes(Name, NameCodes),
    setarg(1, Robot, Name).
