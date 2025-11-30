module ProteinTranslation exposing (Error(..), proteins)

import Dict

type Error
    = InvalidCodon

proteinForCodon = Dict.fromList 
    [ ("AUG", "Methionine")
    , ("UUU", "Phenylalanine")
    , ("UUC", "Phenylalanine")
    , ("UUA", "Leucine")
    , ("UUG", "Leucine")
    , ("UCU", "Serine")
    , ("UCC", "Serine")
    , ("UCA", "Serine")
    , ("UCG", "Serine")
    , ("UAU", "Tyrosine")
    , ("UAC", "Tyrosine")
    , ("UGU", "Cysteine")
    , ("UGC", "Cysteine")
    , ("UGG", "Tryptophan")
    , ("UAA", "STOP")
    , ("UAG", "STOP")
    , ("UGA", "STOP")
    ]

splitList groupSize list = case List.take groupSize list of
    [] -> []
    head -> head :: splitList groupSize (List.drop groupSize list)

triplets = String.toList >> splitList 3 >> List.map String.fromList

unwrap = Maybe.withDefault ""

getProteinForCodon codon = Dict.get codon proteinForCodon

truncate : List (Maybe String) -> List (Maybe String)
truncate list = case list of
    [] -> []
    x::xs -> case x of
        Just("STOP") -> []
        y -> y :: truncate xs
        
analyze : List (Maybe String) -> Result Error (List String)
analyze intermediate =
    if intermediate |> List.any (\k -> k == Nothing) then
        Err InvalidCodon
    else
        Ok (intermediate |> List.map unwrap)

proteins : String -> Result Error (List String)
proteins = 
    triplets >> List.map getProteinForCodon >> truncate >> analyze
        
