from typing import Iterator


def saddle_points(matrix: list[list[int]]) -> list[dict]:
    validate(matrix)
    tallest_per_row = find_tallest_per_row(matrix)
    shortest_per_col = find_shortest_per_col(matrix)
    result = tallest_per_row.intersection(shortest_per_col)
    return [{"row": r + 1, "column": c + 1} for (r, c) in result]


def validate(matrix: list[list[int]]) -> None:
    widths = set(len(r) for r in matrix)
    if len(widths) > 1:
        raise ValueError("irregular matrix")


def find_tallest_per_row(matrix: list[list[int]]) -> list[tuple[int, int]]:
    result = set()
    for i, row in enumerate(matrix):
        max_value = max(row)
        result.update((i, j) for j in indices_of(max_value, row))
    return result


def find_shortest_per_col(matrix: list[list[int]]) -> list[tuple[int, int]]:
    result = set()
    for j, col in enumerate(get_columns(matrix)):
        min_value = min(col)
        result.update((i, j) for i in indices_of(min_value, col))
    return result


def indices_of(key: int, values: list[int]):
    return (i for i in range(len(values)) if values[i] == key)


def get_columns(matrix: list[list[int]]) -> Iterator[list[int]]:
    if matrix:
        for j in range(0, len(matrix[0])):
            yield [matrix[i][j] for i in range(0, len(matrix))]
