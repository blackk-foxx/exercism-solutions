import std/strutils
import std/sequtils

proc stripPunctuation(s: string): string = 
  for c in s:
    if not (c in PunctuationChars):
      result.add(c)
  
proc abbreviate*(s: string): string =
  let normalizedInput = s.replace('-', ' ')
  let nonPunctuatedInput = stripPunctuation(normalizedInput)
  let tokens = nonPunctuatedInput.split(' ')
  let words = tokens.filter(proc(t: string): bool = t.len() > 0)
  map(words, proc(w: string): char = w[0]).join("").toUpperAscii()
