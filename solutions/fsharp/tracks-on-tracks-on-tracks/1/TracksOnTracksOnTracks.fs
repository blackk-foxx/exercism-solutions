module TracksOnTracksOnTracks

let newList: string list = []

let existingList: string list = ["F#"; "Clojure"; "Haskell"]

let addLanguage (language: string) (languages: string list): string list =
    language :: languages

let countLanguages (languages: string list): int = languages.Length

let rec reverseList(languages: string list): string list = 
    match languages with
    | [] -> []
    | [x] -> [x]
    | x :: xs -> reverseList xs @ [x]

let excitingList (languages: string list): bool = 
    match languages with 
    | [] -> false
    | x :: xs -> 
        if x = "F#" then true
        else 
            match xs with
            | [] -> false
            | y :: ys -> y = "F#" && ys.Length < 2
