module TwoFer

let twoFer (input: string option): string = 
    sprintf "One for %s, one for me." (
        match input with
            | Some(name) -> name
            | None -> "you"
    )