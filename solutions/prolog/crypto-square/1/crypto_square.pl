:- use_module(library(clpfd)).

encode(Plaintext, "") :-
    normalize(Plaintext, NormalizedChars),
    length(NormalizedChars, 0),
    !.
encode(Plaintext, Ciphertext) :-
    normalize(Plaintext, NormalizedChars),
    chars_rows(NormalizedChars, Rows),
    transpose(Rows, Columns),
    maplist(atomics_to_string, Columns, ColumnStrings),
    atomics_to_string(ColumnStrings, ' ', Ciphertext).

normalize(String, NormalizedChars) :-
    string_lower(String, LowercaseString),
    string_chars(LowercaseString, Chars),
    include([C] >> char_type(C, alnum), Chars, NormalizedChars).

chars_rows(Chars, Rows) :-
    length(Chars, MessageLength),
    dimensions(MessageLength, _, ColumnCount),
    pad(Chars, ColumnCount, PaddedChars),
    chunk(PaddedChars, ColumnCount, Rows).

dimensions(MessageLength, RowCount, ColumnCount) :-
    Vars = [RowCount, ColumnCount],
    Vars ins 1..MessageLength,
    RowCount * ColumnCount #>= MessageLength,
    ColumnCount #>= RowCount,
    ColumnCount - RowCount #=< 1,
    labeling([min(ColumnCount)], Vars),
    !.

pad(Chars, ChunkSize, Chars) :-
    length(Chars, Length),
    0 is Length mod ChunkSize,
    !.
pad(Chars, ChunkSize, PaddedChars) :-
    length(Chars, Length),
    Offset is ChunkSize - (Length mod ChunkSize),
    length(Padding, Offset),
    maplist(=(' '), Padding),
    append(Chars, Padding, PaddedChars).

chunk([], _, []) :- !.
chunk(List, ChunkSize, [Chunk | Chunks]) :-
    length(Chunk, ChunkSize),
    append(Chunk, Rest, List),
    chunk(Rest, ChunkSize, Chunks).
