import std/strutils
import std/sequtils

proc stripPunctuation(s: string): string = 
  s.filterIt(it notin PunctuationChars).join()
  
proc abbreviate*(input: string): string =
  let normalizedInput = input.replace('-', ' ')
  let nonPunctuatedInput = stripPunctuation(normalizedInput)
  let tokens = nonPunctuatedInput.split(' ')
  let words = tokens.filterIt(it.len() > 0)
  let initials = words.mapIt(it[0])
  initials.join("").toUpperAscii()
