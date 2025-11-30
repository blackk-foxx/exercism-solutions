module TisburyTreasureHunt exposing (..)

-- Consider defining a type alias for TreasureLocation,
-- Treasure, PlaceLocation and Place,
-- and using them in the function type annotations

type alias TreasureLocation = ( Int, Char )
type alias PlaceLocation = ( Char, Int )


placeLocationToTreasureLocation : PlaceLocation -> TreasureLocation
placeLocationToTreasureLocation placeLocation = 
    let (charValue, intValue) = placeLocation
    in (intValue, charValue)


treasureLocationMatchesPlaceLocation : PlaceLocation -> TreasureLocation -> Bool
treasureLocationMatchesPlaceLocation placeLocation treasureLocation =
    treasureLocation == placeLocationToTreasureLocation placeLocation


countPlaceTreasures : ( String, PlaceLocation ) -> List ( String, TreasureLocation ) -> Int
countPlaceTreasures place treasures =
    let 
        (placeName, placeLocation) = place
        targetLocation = placeLocationToTreasureLocation placeLocation
        matchesTargetLocation = \(_, loc) -> loc == targetLocation
    in
        treasures |> List.filter matchesTargetLocation |> List.length


specialCaseSwapPossible : ( String, TreasureLocation ) -> ( String, PlaceLocation ) -> ( String, TreasureLocation ) -> Bool
specialCaseSwapPossible ( foundTreasure, _ ) ( place, _ ) ( desiredTreasure, _ ) =
    case (foundTreasure, place, desiredTreasure) of
        ("Brass Spyglass", "Abandoned Lighthouse", _) -> True
        ("Amethyst Octopus", "Stormy Breakwater", _) -> 
            List.member desiredTreasure ["Crystal Crab", "Glass Starfish"]
        ("Vintage Pirate Hat", "Harbor Managers Office", _) -> 
            List.member desiredTreasure [
                "Antique Glass Fishnet Float", "Model Ship in Large Bottle"
            ]
        _ -> False
