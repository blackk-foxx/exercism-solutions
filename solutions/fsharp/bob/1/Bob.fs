module Bob

let isUppercase (c: char): bool =
    c >= 'A' && c <= 'Z'

let isLowercase (c: char): bool =
    c >= 'a' && c <= 'z'

let isAlpha (c: char): bool = 
    isLowercase c || isUppercase c

let isYelling (input: string): bool = 
    let alphaInput = input |> String.filter isAlpha
    alphaInput.Length > 0 && alphaInput |> String.forall isUppercase

let isQuestion (input: string): bool =
    input.Trim().EndsWith('?')

let isSilence (input: string): bool = 
    input.Trim().Length = 0

let response (input: string): string = 
    if isSilence input then "Fine. Be that way!"
    else if isYelling input && isQuestion input then "Calm down, I know what I'm doing!"
    else if isYelling input then "Whoa, chill out!"
    else if isQuestion input then "Sure."
    else "Whatever."

