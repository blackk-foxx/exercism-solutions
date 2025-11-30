module ReverseString

let rec reverse (input: string): string = 
    match input with
    | "" -> ""
    | s -> (reverse s[1..]) + string s[0]
        