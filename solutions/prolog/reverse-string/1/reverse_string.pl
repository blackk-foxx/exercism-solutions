string_reverse(S, Reversed) :-
    string_chars(S, Chars),
    list_reverse(Chars, [], ReversedChars),
    string_chars(Reversed, ReversedChars).

list_reverse([], Acc, Acc).
list_reverse([Head | Tail], Acc, Reversed) :-
    list_reverse(Tail, [Head | Acc], Reversed).
