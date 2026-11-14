:- use_module(library(dcg/basics)).

wordy(Question, Answer) :- 
    string_codes(Question, Codes),
    phrase(query(Answer), Codes).

query(Result) --> "What is", expr(Result), "?", !.
query(A) --> { throw(error(unknown_operation_error, A)) }.

expr(Result) --> " ", integer(A), expr_tail(A, Result).
expr(_) --> " ", integer(_), " ", unknown_op(Op), 
    { throw(error(unknown_operation_error, Op)) }.
expr(_) --> { throw(error(syntax_error, _)) }.

unknown_op(S) --> alphabetic_greedy_string(S), 
    { length(S, Length), Length > 0, \+ phrase(operator(_), S) }.

alphabetic_greedy_string([Head | Tail]) --> [Head], 
    { is_alpha(Head) }, alphabetic_greedy_string(Tail), !.
alphabetic_greedy_string([]) --> [].

expr_tail(Acc, Value) --> " ", operator(Op), " ", integer(Next),
    { Expr =.. [Op, Acc, Next], NewAcc is Expr },
    expr_tail(NewAcc, Value).
expr_tail(Value, Value) --> "".

operator(+) --> "plus".
operator(-) --> "minus".
operator(*) --> "multiplied by".
operator(//) --> "divided by".
