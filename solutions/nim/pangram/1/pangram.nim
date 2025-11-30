import std/sequtils
import std/strutils
import std/sets
  
proc isPangram*(s: string): bool =
  let allLowercaseLetters = toHashSet(toSeq(LowercaseLetters))
  let normalizedString = toHashSet(normalize(s))
  allLowercaseLetters <= normalizedString
