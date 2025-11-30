module Pangram (isPangram) where
import Data.List
import Data.Char

letters = "abcdefghijklmnopqrstuvwxyz"

isPangram :: String -> Bool
isPangram text = sort (nub (filtered (map toLower text))) == letters

filtered :: String -> String
filtered text = filter (\c -> elem c letters) text