from itertools import pairwise

def rows(row_count):
    match row_count:
        case n if n < 0:
            raise ValueError("number of rows is negative")
        case 0: 
            return []
        case 1: 
            return [[1]]
        case _: 
            upper_rows = rows(row_count - 1)
            middle = [n + m for n, m in pairwise(upper_rows[-1])]
            return upper_rows + [[1, *middle, 1]]
