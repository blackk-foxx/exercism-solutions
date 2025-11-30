module ReverseString (reverseString) where

reverseString :: String -> String
reverseString "" = ""
reverseString (head : tail) = reverseString tail ++ [head]