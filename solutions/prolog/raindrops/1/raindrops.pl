convert(N, Sounds) :-
	findall(Sound, (sound(Div, Sound), 0 =:= N mod Div), SoundList),
    (
        SoundList = [] -> number_string(N, Sounds);
        atomics_to_string(SoundList, Sounds)
    ).

sound(3, "Pling").
sound(5, "Plang").
sound(7, "Plong").
