module KindergartenGarden

open System

type Plant = 
| Clover
| Grass
| Radishes
| Violets

let students = [
    "Alice";
    "Bob";
    "Charlie";
    "David"; 
    "Eve"; 
    "Fred"; 
    "Ginny";
    "Harriet";
    "Ileana";
    "Joseph";
    "Kincaid";
    "Larry"
]

let plantForCode code = 
    match code with 
    | 'C' -> Plant.Clover
    | 'G' -> Plant.Grass
    | 'R' -> Plant.Radishes
    | 'V' -> Plant.Violets

let plants (diagram: string) (student: string) : list<Plant> =
    let studentPosition = students |> List.findIndex (fun name -> name = student)
    let offset = 2 * studentPosition
    let plantsInRow (row: string) : seq<Plant> = 
        row[offset..(offset + 1)] |> Seq.map plantForCode
    diagram.Split(System.Environment.NewLine)
        |> Array.map plantsInRow
        |> Seq.concat
        |> List.ofSeq
