recite(StartVerse, EndVerse, Lyrics) :-
    numlist(StartVerse, EndVerse, VerseNumbers),
    maplist(verse, VerseNumbers, Verses),
    join(Verses, [""], Lyrics).

join([X], _, X) :- !.
join([Head | Tail], Sep, Result) :-
    join(Tail, Sep, TailResult),
    append(Head, Sep, HeadWithSep),
    append(HeadWithSep, TailResult, Result).

verse(N, [FirstLine, "She's dead, of course!"]) :-
    animal(N, "horse", _),
    first_line("horse", FirstLine),
    !.

verse(N, Verse) :-
    beginning(N, Beginning),
    swallow_sequence(N, Middle),
    ending(Ending),
    flatten([Beginning, Middle, Ending], Verse).

animal(1, "fly", "").
animal(2, "spider", "It wriggled and jiggled and tickled inside her.").
animal(3, "bird", "How absurd to swallow a bird!").
animal(4, "cat", "Imagine that, to swallow a cat!").
animal(5, "dog", "What a hog, to swallow a dog!").
animal(6, "goat", "Just opened her throat and swallowed a goat!").
animal(7, "cow", "I don't know how she swallowed a cow!").
animal(8, "horse", "").

beginning(N, [FirstLine]) :-
    animal(N, Animal, ""), first_line(Animal, FirstLine), !.

beginning(N, [FirstLine, Description]) :-
    animal(N, Animal, Description),
    first_line(Animal, FirstLine).

first_line(Animal, FirstLine) :-
    format(string(FirstLine), "I know an old lady who swallowed a ~w.", [Animal]).

swallow_sequence(1, []) :- !.
swallow_sequence(N, [Head | Tail]) :-
    NextN is N - 1,
    swallow_line(N, Head),
    swallow_sequence(NextN, Tail).

ending(["I don't know why she swallowed the fly. Perhaps she'll die."]).

swallow_line(PredatorN, Line) :-
    PreyN is PredatorN - 1,
    prey(PreyN, Prey),
    animal(PredatorN, Predator, _),
    format(string(Line), "She swallowed the ~w to catch the ~w.", [Predator, Prey]).

prey(N, "spider that wriggled and jiggled and tickled inside her") :-
    animal(N, "spider", _), !.
prey(N, Animal) :- animal(N, Animal, _).
