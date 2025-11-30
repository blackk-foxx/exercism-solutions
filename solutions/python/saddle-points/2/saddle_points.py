from typing import Iterator

Matrix = list[list[int]]
Coords = tuple[int, int]


def saddle_points(matrix: Matrix) -> list[dict]:
    validate(matrix)
    columns = get_columns(matrix)
    tallest_per_row = find_tallest_per_row(matrix)
    result = filter_all_but_shortest_per_col(columns, tallest_per_row)
    return [{"row": r + 1, "column": c + 1} for (r, c) in result]


def validate(matrix: Matrix) -> None:
    widths = set(len(r) for r in matrix)
    if len(widths) > 1:
        raise ValueError("irregular matrix")


def find_tallest_per_row(matrix: Matrix) -> set[Coords]:
    result = set()
    for i, row in enumerate(matrix):
        max_value = max(row)
        result.update((i, j) for j, v in enumerate(row) if v == max_value)
    return result


def filter_all_but_shortest_per_col(columns: Matrix, candidates: set[Coords]) -> set[Coords]:
    result = set()
    for j, col in enumerate(columns):
        min_value = min(col)
        result.update(
            (i, jj) for (i, jj) in candidates 
            if jj == j and col[i] == min_value
        )
    return result


def get_columns(matrix: Matrix) -> Iterator[list[int]]:
    if matrix:
        for j in range(0, len(matrix[0])):
            yield [matrix[i][j] for i in range(0, len(matrix))]
