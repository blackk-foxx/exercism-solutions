paired(String) :-
    string_codes(String, Codes),
    include([C] >> member(C, `([{}])`), Codes, FilteredCodes),
    phrase(expression_sequence, FilteredCodes).

expression_sequence --> [].
expression_sequence --> expression, expression_sequence.

expression --> balanced("[", "]"); balanced("(", ")"); balanced("{", "}").

balanced(Begin, End) --> Begin, expression_sequence, End.
