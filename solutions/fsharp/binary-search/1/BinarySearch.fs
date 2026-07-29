module BinarySearch

let rec find_in_range low high (input: int array) value =
    if low >= high then None
    else
        let mid = (low + high) / 2
        match input[mid] with
        | n when n = value -> Some mid
        | n when n < value -> find_in_range (mid + 1) high input value
        | _ -> find_in_range low mid input value

let find input value = 
    find_in_range 0 (Array.length input) input value
