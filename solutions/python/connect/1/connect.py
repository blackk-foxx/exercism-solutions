from typing import Callable, Generator


class ConnectGame:
    def __init__(self, board: str) -> None:
        self.board = Board(board)

    def get_winner(self) -> str:
        for r in range(self.board.height):
            if self.board[r][0] == "X":
                if self.horizontal_path_exists(r, 0):
                    return "X"
        for c in range(self.board.width):
            if self.board[0][c] == "O":
                if self.vertical_path_exists(0, c):
                    return "O"
        return ""

    def horizontal_path_exists(self, row: int, column: int) -> bool:
        return self.path_exists(row, column, self.board.is_at_last_column)
    
    def vertical_path_exists(self, row: int, column: int) -> bool:
        return self.path_exists(row, column, self.board.is_at_last_row)

    def path_exists(self, row: int, column: int, target_reached: Callable[[int, int], bool]) -> bool:
        pathfinder = Pathfinder(
            board = self.board,
            player = self.board[row][column],
            target_reached = target_reached
        )
        return pathfinder.path_exists(row, column)


class Board:
    def __init__(self, board: str):
        self.rows = [r.strip().split() for r in board.splitlines()]

    def __getitem__(self, row: int) -> list[str]:
        return self.rows[row]
    
    @property
    def height(self) -> int:
        return len(self.rows)
    
    @property
    def width(self) -> int:
        return len(self.rows[0])

    def get_adjacent_positions(self, row: int, column: int) -> Generator[tuple[int, int], None, None]:
        offsets = ((0, -1), (-1, 0), (-1, 1), (0, 1), (1, 0), (1, -1))
        positions = ((row + dr, column + dc) for dr, dc in offsets)
        return ((r, c) for r, c in positions if 0 <= r < self.height and 0 <= c < self.width)

    def is_at_last_row(self, row: int, _column: int) -> bool:
        return row == self.height - 1
    
    def is_at_last_column(self, _row: int, column: int) -> bool:
        return column == self.width - 1


class Pathfinder:
    def __init__(self, board: Board, player: str, target_reached: Callable[[int, int], bool]):
        self.board = board
        self.player = player
        self.visited = set()
        self.target_reached = target_reached

    def path_exists(self, row: int, column: int) -> bool:
        if self.target_reached(row, column):
            return True
        self.visited.add((row, column))
        return any(
            self.path_exists(r, c)
            for r, c in self.board.get_adjacent_positions(row, column)
            if (r, c) not in self.visited and self.board[r][c] == self.player
        )
