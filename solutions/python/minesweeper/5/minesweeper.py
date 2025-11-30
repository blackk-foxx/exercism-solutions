def annotate(minefield):
    validate(minefield)
    return list(AnnotatedMinefield(minefield))


class AnnotatedMinefield:

    neighborhood_offsets = {
        (-1, -1), (-1, 0), (-1, 1),
        (0, -1), (0, 0), (0, 1),
        (1, -1), (1, 0), (1, 1)
    }

    def __init__(self, minefield):
        self.minefield = minefield
        self.height, self.width = measure(minefield)
        self.dict = to_dict(minefield)

    def __iter__(self):
        for i in range(self.height):
            yield self.get_output_row(i)

    def get_output_row(self, i):
        return ''.join(
            self.get_output_value_at(i, j) 
            for j in range(self.width)
        )

    def get_output_value_at(self, i, j):
        count = self.count_neighboring_mines_at(i, j)
        return (
            '*' if self.dict[(i, j)] == '*' 
            else ' ' if count == 0 
            else str(count)
        )

    def count_neighboring_mines_at(self, i, j):
        coords = self.get_neighborhood_coords_at(i, j)
        return self.count_mines_at_coords(coords)
        
    def get_neighborhood_coords_at(self, i, j):
        return {
            (u+i, v+j) for (u, v) in self.neighborhood_offsets
            if 0 <= (u+i) < self.height and 0 <= (v+j) < self.width
        }

    def count_mines_at_coords(self, coords):
        return sum(
            1 if self.dict[c] == '*' else 0
            for c in coords
        )


def validate(minefield):
    if len(minefield) == 0:
        return
    ensure_rows_have_equal_width(minefield)
    ensure_cells_have_valid_symbols(minefield)


ERROR_MSG = "The board is invalid with current input."


def ensure_rows_have_equal_width(minefield):
    first_row = minefield[0]
    if not all(len(row) == len(first_row) for row in minefield[1:]):
        raise ValueError(ERROR_MSG)


def ensure_cells_have_valid_symbols(minefield):
    for row in minefield:
        if not all(c in [' ', '*'] for c in row):
            raise ValueError(ERROR_MSG)
    

def measure(minefield):
    height = len(minefield)
    width = 0 if height == 0 else len(minefield[0])
    return height, width


def to_dict(minefield):
    return {
        (i,j): cell 
        for i, row in enumerate(minefield)
        for j, cell in enumerate(row)
    }
