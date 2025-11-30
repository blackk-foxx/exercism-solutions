def annotate(minefield):
    validate(minefield)
    for i, in_row in enumerate(minefield):
        out_row = []
        for j, cell in enumerate(in_row):
            if cell.isspace():
                count = get_nearby_mine_count(minefield, i, j)
                out_row.append(str(count) if count else ' ')
            else:
                out_row.append(cell)
        minefield[i] = ''.join(out_row)
    return minefield


def validate(minefield):
    if not minefield:
        return
    msg = "The board is invalid with current input."
    first_row = minefield[0]
    if not all(len(row) == len(first_row) for row in minefield[1:]):
        raise ValueError(msg)
    for row in minefield:
        if not all(c in [' ', '*'] for c in row):
            raise ValueError(msg)


def get_nearby_mine_count(minefield, i, j):
    starting_row = max(0, i-1)
    ending_row = min(i+1, len(minefield)-1)
    starting_col = max(0, j-1)
    ending_col = min(j+1, len(minefield[0])-1)
    count = 0
    for row in minefield[starting_row: ending_row+1]:
        for cell in row[starting_col: ending_col+1]:
            count += 1 if cell == '*' else 0
    return count

