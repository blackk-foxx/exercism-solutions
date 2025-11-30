module Allergies

type Allergen = 
| Eggs = 1
| Peanuts = 2
| Shellfish = 4
| Strawberries = 8
| Tomatoes = 16
| Chocolate = 32
| Pollen = 64
| Cats = 128

let allergicTo (codedAllergies: int) (allergen: Allergen): bool =
    0 < ((int allergen) &&& codedAllergies)

let allAllergens: List<Allergen> = 
    System.Enum.GetValues(typeof<Allergen>) |> Seq.cast<Allergen> |> List.ofSeq

let list (codedAllergies: int): List<Allergen> = 
     allAllergens |> List.filter (allergicTo codedAllergies)
