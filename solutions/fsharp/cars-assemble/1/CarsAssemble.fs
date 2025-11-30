module CarsAssemble

let base_production_rate = 221

let successRate (speed: int): float =
    if speed = 0 then
        0
    elif 1 <= speed && speed <= 4 then
        1.0
    elif 5 <= speed && speed <= 8 then
        0.90
    elif speed = 9 then
        0.80
    else
        0.77

let productionRatePerHour (speed: int): float = 
    (float (base_production_rate * speed)) * (successRate speed)

let workingItemsPerMinute (speed: int): int =
    (int ((productionRatePerHour speed) / 60.0))
