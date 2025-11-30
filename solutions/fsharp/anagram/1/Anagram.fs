module Anagram

let isAnagram (target: string) (candidate: string) =
    let lowerTarget = target.ToLower()
    let lowerCandidate = candidate.ToLower()
    if lowerTarget = lowerCandidate then
        false
    else
        let sortedTarget = lowerTarget |> Seq.toList |> List.sort
        let sortedCandidate = lowerCandidate |> Seq.toList |> List.sort
        sortedTarget = sortedCandidate

let findAnagrams (sources: string list) (target: string) = 
    sources |> List.filter (isAnagram target) 
