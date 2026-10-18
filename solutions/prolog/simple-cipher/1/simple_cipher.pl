generate_key(Key) :-
    length(Codes, 100),
    maplist(random_between(0'a, 0'z), Codes),
    string_codes(Key, Codes).
    
encode(Plaintext, Key, Ciphertext) :-
    transform(Plaintext, Key, 1, Ciphertext).

decode(Ciphertext, Key, Plaintext) :-
    transform(Ciphertext, Key, -1, Plaintext).

transform(Input, Key, Direction, Output) :-
    string_codes(Input, InputCodes),
    string_codes(Key, KeyCodes),
    rotate(InputCodes, KeyCodes, Direction, OutputCodes),
    string_codes(Output, OutputCodes).

rotate(Codes, KeyCodes, Direction, RotatedCodes) :-
    rotate(Codes, KeyCodes, Direction, [], RevRotatedCodes),
    reverse(RevRotatedCodes, RotatedCodes).

rotate([], _, _, Acc, Acc).
rotate([Head | Tail], [HeadKeyCode | TailKeyCodes], Direction, Acc, RotatedCodes) :-
    rotate_code(Head, HeadKeyCode, Direction, RotatedHead),
    append(TailKeyCodes, [HeadKeyCode], NewKeyCodes),
    rotate(Tail, NewKeyCodes, Direction, [RotatedHead | Acc], RotatedCodes).

rotate_code(Code, KeyCode, Direction, RotatedCode) :-
    KeyOffset is KeyCode - 0'a,
    CodeOffset is Code - 0'a,
    RotatedOffset is (CodeOffset + (Direction * KeyOffset)) mod 26,
    RotatedCode is RotatedOffset + 0'a.
