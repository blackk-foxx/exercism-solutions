recite(N, [Lyrics]) :-
    preamble(N, Preamble),
    numlist(1, N, GiftNumbers),
    maplist(gift, GiftNumbers, Gifts),
    join_gifts(Gifts, GiftSequence),
    atomics_to_string([Preamble, GiftSequence, "."], Lyrics).
    
recite(From, To, Lyrics) :-
    numlist(From, To, Numbers),
    maplist(recite, Numbers, LyricLists),
    flatten(LyricLists, Lyrics).

preamble(N, Preamble) :-
    preamble_fmt(PreambleFmt),
    ordinal(N, Ordinal),
    format(string(Preamble), PreambleFmt, [Ordinal]).
    
preamble_fmt("On the ~w day of Christmas my true love gave to me: ").

join_gifts([FirstGift], FirstGift) :- !.
join_gifts([FirstGift | RemainingGifts], GiftSequence) :-
    reverse(RemainingGifts, RevRemainingGifts),
    atomics_to_string(RevRemainingGifts, ", ", RemainingGiftSequence), 
    atomics_to_string([RemainingGiftSequence, ", and ", FirstGift], GiftSequence).
    
ordinal(1, first).
ordinal(2, second).
ordinal(3, third).
ordinal(4, fourth).
ordinal(5, fifth).
ordinal(6, sixth).
ordinal(7, seventh).
ordinal(8, eighth).
ordinal(9, ninth).
ordinal(10, tenth).
ordinal(11, eleventh).
ordinal(12, twelfth).

gift(1, "a Partridge in a Pear Tree").
gift(2, "two Turtle Doves").
gift(3, "three French Hens").
gift(4, "four Calling Birds").
gift(5, "five Gold Rings").
gift(6, "six Geese-a-Laying").
gift(7, "seven Swans-a-Swimming").
gift(8, "eight Maids-a-Milking").
gift(9, "nine Ladies Dancing").
gift(10, "ten Lords-a-Leaping").
gift(11, "eleven Pipers Piping").
gift(12, "twelve Drummers Drumming").
