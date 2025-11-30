module AnnalynsInfiltration exposing (canFastAttack, canFreePrisoner, canSignalPrisoner, canSpy, stealthAttackDamage)

import List exposing (length, filter)

canFastAttack : Bool -> Bool
canFastAttack knightIsAwake = not knightIsAwake


canSpy : Bool -> Bool -> Bool -> Bool
canSpy knightIsAwake archerIsAwake prisonerIsAwake = 
    let
        any : (a -> Bool) -> List a -> Bool
        any p l = length(filter p l) > 0
    in 
        any ((==) True) [knightIsAwake, archerIsAwake, prisonerIsAwake]


canSignalPrisoner : Bool -> Bool -> Bool
canSignalPrisoner archerIsAwake prisonerIsAwake = prisonerIsAwake && not archerIsAwake


canFreePrisoner : Bool -> Bool -> Bool -> Bool -> Bool
canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent =
    if petDogIsPresent then not archerIsAwake
    else
        prisonerIsAwake && not (knightIsAwake || archerIsAwake)


stealthAttackDamage : Bool -> Int
stealthAttackDamage annalynIsDetected =
    if annalynIsDetected then 7 else 12
