module PigLatin

open System.Text.RegularExpressions

let splitPrefix (word: string) : (string * string) option = 
    [
        @"(^xr.*|^yt.*)()";
        @"^([^aeiou]*qu)(.*)";
        @"^([^aeiou]+)([aeiouy].*)"
        @"^([^aeiou]+)(.*)";
    ] 
        |> List.map (fun pattern -> Regex.Match(word, pattern))
        |> Seq.tryFind (fun _match -> _match.Success)
        |> Option.map (fun _match -> (_match.Groups[1].Value, _match.Groups[2].Value))

let translateWord word = 
    match splitPrefix word with
    | Some(head, tail) -> tail + head + "ay"
    | None -> word + "ay"

let translate (input: string) : string =
    input.Split(' ') |> Array.map translateWord |> String.concat " "
