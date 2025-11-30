module MariosMarvellousLasagna exposing (remainingTimeInMinutes)

remainingTimeInMinutes : Int -> Int -> Int
remainingTimeInMinutes layers elapsedTimeInMinutes = 

    let 
        expectedMinutesInOven = 40
        preparationTimeInMinutes : Int -> Int
        preparationTimeInMinutes l = 2 * l
    in 
        preparationTimeInMinutes layers + expectedMinutesInOven - elapsedTimeInMinutes