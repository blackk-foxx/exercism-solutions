module ProteinTranslation exposing (Error(..), proteins)

import Dict

type Error
    = InvalidCodon

codonProteinAssociations : List (List String, String)
codonProteinAssociations = [
        (["AUG"], "Methionine"),
        (["UUC", "UUU"], "Phenylalanine"),
        (["UUA", "UUG"], "Leucine"),
        (["UCU", "UCC", "UCA", "UCG"], "Serine"),
        (["UAU", "UAC"], "Tyrosine"),
        (["UGU", "UGC"], "Cysteine"),
        (["UGG"], "Tryptophan"),
        (["UAA", "UAG", "UGA"], "STOP")
    ]

expandAssociation : (List String, String) -> List (String, String)
expandAssociation  (codons, protein) = 
        codons |> List.map (\c -> (c, protein))

proteinForCodon : Dict.Dict String String
proteinForCodon =
    codonProteinAssociations |> List.concatMap expandAssociation |> Dict.fromList

splitList : Int -> List Char -> List (List Char)
splitList groupSize list = case List.take groupSize list of
    [] -> []
    head -> head :: (list |> List.drop groupSize |> splitList groupSize)

codonSize : Int
codonSize = 3

triplets : String -> List String
triplets = String.toList >> splitList codonSize >> List.map String.fromList

getProteinForCodon : String -> Maybe String
getProteinForCodon codon = Dict.get codon proteinForCodon

truncate : List (Maybe String) -> List (Maybe String)
truncate list = case list of
    [] -> []
    x::xs -> case x of
        Just("STOP") -> []
        y -> y :: truncate xs
        
validate : List (Maybe String) -> Result Error (List String)
validate intermediate =
    if intermediate |> List.member Nothing then
        Err InvalidCodon
    else
        Ok (intermediate |> List.filterMap identity)

proteins : String -> Result Error (List String)
proteins = 
    triplets >> List.map getProteinForCodon >> truncate >> validate
        
