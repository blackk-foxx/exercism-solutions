module RnaTranscription exposing (toRNA)

import Dict

rnaForDna = Dict.fromList [('C', 'G'), ('G', 'C'), ('T', 'A'), ('A', 'U')]

isValid = 
    String.toList >> List.all (\k -> Dict.member k rnaForDna)

toRNA : String -> Result String String
toRNA dna =
    if isValid dna then
        dna |> String.map (\k -> Dict.get k rnaForDna |> Maybe.withDefault '-') |> Ok
    else
        Err "Invalid input"
