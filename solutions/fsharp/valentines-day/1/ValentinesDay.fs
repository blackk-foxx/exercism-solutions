module ValentinesDay

type Approval = 
    | Yes
    | No
    | Maybe

type Cuisine = 
    | Korean
    | Turkish

type Genre = 
    | Crime
    | Horror
    | Romance
    | Thriller
    
type Activity = 
    | BoardGame
    | Chill
    | Movie of Genre
    | Restaurant of Cuisine
    | Walk of int

let rateActivity (activity: Activity): Approval = 
    match activity with
    | BoardGame -> No
    | Chill -> No
    | Movie genre -> 
        match genre with 
        | Romance -> Yes
        | _ -> No
    | Restaurant cuisine -> 
        match cuisine with
        | Korean -> Yes
        | Turkish -> Maybe
    | Walk distance -> 
        if distance < 3 then Yes
        elif distance < 5 then Maybe
        else No
