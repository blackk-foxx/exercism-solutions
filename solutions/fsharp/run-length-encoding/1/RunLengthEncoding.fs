module RunLengthEncoding

open System


let rec countRepeated (c: char) (s: string): int = 
    if s.Length = 0 || not (s.StartsWith(c)) then 0
    else 1 + countRepeated c s[1..]

let rec repeat (c: char) (count: int): string = 
    if count = 0 then ""
    else (string c) + repeat c (count - 1)

let rec getLeadingDigits (input: string): string = 
    if Char.IsDigit input[0] then 
        (string input[0]) + getLeadingDigits input[1..]
    else 
        ""
    
let rec encode (input: string): string = 
    if input= "" then ""
    else
        let firstChar = input[0]
        let count = countRepeated firstChar input
        let prefix =
            if count > 1 then 
                encode (string count) + (string firstChar)
            else 
                string firstChar
        prefix + encode input[count..]

let rec decode input = 
    if input = "" then ""
    else
        let digits = getLeadingDigits input
        let prefix = 
            if digits.Length > 0 then 
                repeat input[digits.Length] (int digits)
            else
                string input[0]
        prefix + decode input[(digits.Length + 1)..]