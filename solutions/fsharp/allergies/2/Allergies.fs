module Allergies

open System

type Allergen = 
| Eggs = 1
| Peanuts = 2
| Shellfish = 4
| Strawberries = 8
| Tomatoes = 16
| Chocolate = 32
| Pollen = 64
| Cats = 128

let allergicTo (codedAllergies: int) (allergen: Allergen) =
    (int allergen) &&& codedAllergies > 0

let list (codedAllergies: int) = 
    Enum.GetValues<Allergen>() |> Seq.filter (allergicTo codedAllergies) |> List.ofSeq
