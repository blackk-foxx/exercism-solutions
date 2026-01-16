module PizzaPricing

type Pizza =
    | Margherita
    | Caprese
    | Formaggio
    | ExtraSauce of Pizza
    | ExtraToppings of Pizza

let rec pizzaPrice (pizza: Pizza): int =
    match pizza with
    | Margherita -> 7
    | Caprese -> 9
    | Formaggio -> 10
    | ExtraSauce basePizza -> 1 + pizzaPrice basePizza
    | ExtraToppings basePizza -> 2 + pizzaPrice basePizza    

let orderPrice (pizzas: Pizza list): int =
    let surcharge = 
        match List.length pizzas with
        | 1 -> 3
        | 2 -> 2
        | _ -> 0
    (pizzas |> List.map pizzaPrice |> List.sum) + surcharge
