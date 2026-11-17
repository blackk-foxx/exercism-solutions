:- use_module(library(dcg/basics)).

wordy(Question, Answer) :- 
    string_codes(Question, Codes),
    phrase(query(Answer), Codes).

query(Result) --> "What is", expression(Result), "?"; { invalid_query }.

expression(Result) --> " ", integer(Lhs), expression_tail(Lhs, Result); 
    { syntax_error }.

expression_tail(Lhs, Result) --> " ", operator(Op), " ", integer(Rhs),
    { Expression =.. [Op, Lhs, Rhs], NextLhs is Expression },
    expression_tail(NextLhs, Result).
expression_tail(A, A) --> "".

operator(+) --> "plus", !.
operator(-) --> "minus", !.
operator(*) --> "multiplied by", !.
operator(//) --> "divided by", !.
operator(_) --> nonempty_alphabetic_string(Op), { unknown_operator(Op) }.

unknown_operator(OpCodes) :- 
    string_codes(OpStr, OpCodes), throw(error(unknown_operation_error, OpStr)).
invalid_query :- throw(error(unknown_operation_error, "invalid query")).
syntax_error :- throw(error(syntax_error, "syntax error")).

nonempty_alphabetic_string([C|Cs]) --> [C],
    { code_type(C, alpha) },
    nonempty_alphabetic_string(Cs).
nonempty_alphabetic_string([C]) --> [C],
    { code_type(C, alpha) }.
