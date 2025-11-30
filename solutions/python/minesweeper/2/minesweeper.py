def annotate(minefield):
    validate(minefield)
    counts = calculate_counts(minefield)
    for i, in_row in enumerate(minefield):
        out_row = []
        for j, cell in enumerate(in_row):
            if cell == '*':
                out_row.append('*')
            elif counts[i][j] == 0:
                out_row.append(' ')
            else:
                out_row.append(str(counts[i][j]))
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


def calculate_counts(minefield):
    counts = []
    for row in minefield:
        counts.append([0] * len(row))
    for i, in_row in enumerate(minefield):
        for j, cell in enumerate(in_row):
            if cell == '*':
                increment_neighbors(counts, i, j)
    return counts


def increment_neighbors(counts, i, j):
    starting_row = max(0, i-1)
    ending_row = min(i+1, len(counts)-1)
    starting_col = max(0, j-1)
    ending_col = min(j+1, len(counts[0])-1)
    for row in counts[starting_row: ending_row+1]:
        for i in range(starting_col, ending_col+1):
            row[i] += 1
