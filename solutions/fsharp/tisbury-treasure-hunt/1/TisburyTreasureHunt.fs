module TisburyTreasureHunt

let getCoordinate (line: string * string): string =
    snd line

let convertCoordinate (coordinate: string): int * char = 
    (coordinate[0] - '0' |> int, coordinate[1])

let compareRecords (azarasData: string * string) (ruisData: string * (int * char) * string) : bool = 
    let (_, ruisCoord, __) = ruisData
    azarasData |> getCoordinate |> convertCoordinate = ruisCoord

let createRecord (azarasData: string * string) (ruisData: string * (int * char) * string) : (string * string * string * string) =
    if compareRecords azarasData ruisData then 
        let (treasure, coord) = azarasData
        let (location, _, quadrant) = ruisData
        (coord, location, quadrant, treasure)
    else
        ("", "", "", "")
