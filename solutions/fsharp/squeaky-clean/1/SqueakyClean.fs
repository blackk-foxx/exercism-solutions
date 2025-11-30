module SqueakyClean

open System

let transform (c: char) : string =
    match c with 
    | '-' -> "_"
    | ' ' -> ""
    | c when Char.IsUpper c -> "-" + (c |> Char.ToLower |> string) 
    | c when Char.IsDigit c -> ""
    | c when 'α' <= c && c <= 'ω' -> "?"
    | _ -> string c
    
let clean (identifier: string): string =
    identifier |> String.collect (fun c -> transform c)
