module GuessingGame

[<Literal>]
let Target = 42

let reply (guess: int): string = 
    match guess with
    | n when n < (Target - 1) -> "Too low"
    | n when (abs (n - Target)) = 1 -> "So close"
    | Target -> "Correct"
    | _ -> "Too high"
