module Accumulate

let rec accumulate_helper func acc input = 
    match input with
    | [] -> acc
    | x :: xs -> accumulate_helper func (func x :: acc) xs

let accumulate (func: 'a -> 'b) (input: 'a list): 'b list = 
    accumulate_helper func [] input |> List.rev
