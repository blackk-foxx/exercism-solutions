module FoodChain (song) where
import Data.List

song :: String
song = intercalate "\n" verses

  where

  verses = initial_verses ++ [last_verse]
  initial_verses = [a ++ b ++ c ++ verse_ending | (a,b,c) <- zip3 (init verse_heads) (init verse_middles) verse_tails]
  last_verse = (last verse_heads) ++ (last verse_middles)
  verse_heads = [verse_beginning ++ a ++ ".\n" | a <- animals]
  verse_tails = make_verse_tails verse_tail_parts
  verse_beginning = "I know an old lady who swallowed a "
  verse_ending = "I don't know why she swallowed the fly. Perhaps she'll die.\n"
  animals = ["fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"]

  verse_middles = [
      "",
      "It wriggled and jiggled and tickled inside her.\n",
      "How absurd to swallow a bird!\n",
      "Imagine that, to swallow a cat!\n",
      "What a hog, to swallow a dog!\n",
      "Just opened her throat and swallowed a goat!\n",
      "I don't know how she swallowed a cow!\n",
      "She's dead, of course!\n"]

  make_verse_tails :: [String] -> [String]
  make_verse_tails [] = []
  make_verse_tails parts = make_verse_tails (init parts) ++ [intercalate "" (reverse parts)]

  verse_tail_parts = [""] ++ ["She swallowed the " ++ p ++ "\n" | p <- verse_tail_unique_parts]
  verse_tail_unique_parts = make_verse_tail_unique_parts animals

  make_verse_tail_unique_parts :: [String] -> [String]
  make_verse_tail_unique_parts [prey] = []
  make_verse_tail_unique_parts (prey:others) = [part] ++ (make_verse_tail_unique_parts others)
    where
    predator = head others
    part = predator ++ " to catch the " ++ prey ++ description prey ++ "."
    description "spider" = " that wriggled and jiggled and tickled inside her" 
    description _ = ""