import std/strformat
  
type
  Allergen* = enum
    Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats

proc isAllergicTo*(score: int, allergen: Allergen): bool =
  (score and cast[int]({allergen})) > 0

proc allergies*(score: int): set[Allergen] =
  cast[set[Allergen]](score)
