import std/sequtils
import strutils


proc isQuestion(s: string): bool = 
  s[^1] == '?'
  
proc isYelling(s: string): bool = 
  all(s, proc(c: char): bool = isUpperAscii(c) or not isAlphaAscii(c)) and
  any(s, proc(c: char): bool = isUpperAscii(c))

proc hey*(s: string): string =
  let prompt:string = strip(s)

  if isEmptyOrWhitespace(prompt):
    "Fine. Be that way!"
  elif isYelling(prompt):
    if isQuestion(prompt):
      "Calm down, I know what I'm doing!"
    else:
      "Whoa, chill out!"
      
  elif isQuestion(prompt):
    "Sure."
  else:
    "Whatever."
