import sequtils
import std/strformat
  
proc distance*(a, b: string): int =
  if len(a) != len(b):
    raise new(ref ValueError)
  for _, (c1, c2) in zip(a, b):
    if c1 != c2:
      result += 1
