module LeapYear (isLeapYear) where

isLeapYear :: Integer -> Bool
isLeapYear year = divisibleBy year 4 && not (divisibleBy year 100) || divisibleBy year 400 
  where
    divisibleBy x y = mod x y == 0



