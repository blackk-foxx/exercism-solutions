module FoodChain (song) where
import Data.List

song :: String
song = intercalate "\n" verses

  where

  verses = initial_verses ++ [last_verse]
  initial_verses = [a ++ b ++ c ++ verse_ending | (a,b,c) <- zip3 (init verse_heads) (init verse_middles) verse_tails]
  last_verse = (last verse_heads) ++ (last verse_middles)
  verse_heads = [verse_beginning ++ a ++ ".\n" | a <- animals]
  verse_tails = get_verse_tails verse_tail_parts
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

  get_verse_tails :: [String] -> [String]
  get_verse_tails [] = []
  get_verse_tails (a) = get_verse_tails (init a) ++ [intercalate "" (reverse a)]

  verse_tail_parts = [""] ++ ["She swallowed the " ++ a ++ "\n" | a <- verse_tail_unique_parts]

  verse_tail_unique_parts = [
    "spider to catch the fly.",
    "bird to catch the spider that wriggled and jiggled and tickled inside her.",
    "cat to catch the bird.",
    "dog to catch the cat.",
    "goat to catch the dog.",
    "cow to catch the goat."]
