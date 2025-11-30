module BirdWatcher

let lastWeek: int[] = [| 0; 2; 5; 3; 7; 8; 4 |]

let yesterday(counts: int[]): int = counts[counts.Length - 2]

let total(counts: int[]): int = Array.sum counts

let dayWithoutBirds(counts: int[]): bool = 
    Array.exists (fun n -> n = 0) counts

let incrementTodaysCount(counts: int[]): int[] = 
    let last = counts.Length - 1
    counts[last] <- counts[last] + 1
    counts

let unusualWeek(counts: int[]): bool =
    let filterByIndex (predicate: int * 'a -> bool): 'a array -> 'a array =
        Array.mapi(fun i x -> i, x) 
        >> Array.filter(predicate) 
        >> Array.map(fun (i, x) -> x)
    let evenDays = counts |> filterByIndex (fun (i, x) -> i % 2 = 1)
    let oddDays = counts |> filterByIndex (fun (i, x) -> i % 2 = 0)
    let unusualEvenDays = evenDays |> Array.forall (fun x -> x = 0 || x = 10)
    let unusualOddDays = oddDays |> Array.forall (fun x -> x = 5)
    unusualEvenDays || unusualOddDays