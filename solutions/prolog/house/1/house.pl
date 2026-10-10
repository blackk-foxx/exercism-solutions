recite(From, To, Lyrics) :-
    numlist(From, To, VerseNumbers),
    maplist(verse, VerseNumbers, Lyrics).

recite(VerseNumber, Lyrics) :- recite(VerseNumber, VerseNumber, Lyrics).

verse(VerseNumber, Verse) :-
    number_phrase(VerseNumber, Phrase),
    string_concat("This is ", Phrase, Verse).
    
number_phrase(1, "the house that Jack built.") :- !.
number_phrase(N, Phrase) :-
    NextN is N - 1,
    number_phrase(NextN, NextPhrase),
    phrase_fragment(N, PhraseFragment),
    atomics_to_string(["the", PhraseFragment, NextPhrase], " ", Phrase).

phrase_fragment(2, "malt that lay in").
phrase_fragment(3, "rat that ate").
phrase_fragment(4, "cat that killed").
phrase_fragment(5, "dog that worried").
phrase_fragment(6, "cow with the crumpled horn that tossed").
phrase_fragment(7, "maiden all forlorn that milked").
phrase_fragment(8, "man all tattered and torn that kissed").
phrase_fragment(9, "priest all shaven and shorn that married").
phrase_fragment(10, "rooster that crowed in the morn that woke").
phrase_fragment(11, "farmer sowing his corn that kept").
phrase_fragment(12, "horse and the hound and the horn that belonged to").
