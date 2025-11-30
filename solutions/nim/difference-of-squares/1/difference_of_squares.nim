import math
import sequtils
  
proc squareOfSum*(n: int): int =
  sum(toSeq(1..n)) ^ 2

proc sumOfSquares*(n: int): int =
  sum(toSeq(1..n).mapIt(it ^ 2))

proc difference*(n: int): int =
  squareOfSum(n) - sumOfSquares(n)
