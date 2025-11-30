module LuciansLusciousLasagna

let expectedMinutesInOven = 40

let remainingMinutesInOven elapsed = expectedMinutesInOven - elapsed

let prepTimePerLayer = 2

let preparationTimeInMinutes layers = prepTimePerLayer * layers

let elapsedTimeInMinutes layers elapsed = 
    elapsed + preparationTimeInMinutes layers
