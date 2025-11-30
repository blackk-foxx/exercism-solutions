module RomanNumerals

open System

let rec roman arabicNumeral = 
    let romanForValue = Map.ofList [
        (0, ""); (1, "I"); (5, "V"); (10, "X"); (50, "L"); (100, "C"); (500, "D"); (1000, "M")
    ]

    match romanForValue.TryFind arabicNumeral with
    | Some(s) -> s
    | None ->
        let n = arabicNumeral
        let order = int (Math.Log10 n)
        let unit = pown 10 order
        let upper = 10 * unit
        let mid = upper / 2
        let (upperBound, increment) = if n < mid then (mid, unit) else (upper, mid)
        let incrementLimit = upperBound - unit
        if n < incrementLimit then 
            romanForValue.[increment] + roman (n - increment)
        else 
            romanForValue.[unit] + romanForValue.[upperBound] + roman (n - incrementLimit) 
