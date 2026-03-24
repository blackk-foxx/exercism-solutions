from typing import Callable, Generator, Iterable


class ConnectGame:
    """
        A Connect game model
    """
    def __init__(self, board: str) -> None:
        """
            Construct a ConnectGame from the given string representation of the board
        """
        self.board = Board(board)

    def get_winner(self) -> str:
        """
            Get the winner -- "X", "O", or "".
        """
        for row in range(self.board.height):
            if self.board[row][0] == "X":
                if self._horizontal_path_exists(row, 0):
                    return "X"
        for column in range(self.board.width):
            if self.board[0][column] == "O":
                if self._vertical_path_exists(0, column):
                    return "O"
        return ""

    def _horizontal_path_exists(self, row: int, column: int) -> bool:
        return self._path_exists(row, column, self.board.is_at_last_column)
    
    def _vertical_path_exists(self, row: int, column: int) -> bool:
        return self._path_exists(row, column, self.board.is_at_last_row)

    def _path_exists(self, row: int, column: int, target_reached: Callable[[int, int], bool]) -> bool:
        pathfinder = Pathfinder(
            board = self.board,
            player = self.board[row][column],
            target_reached = target_reached
        )
        return pathfinder.path_exists(row, column)


class Board:
    """
        A Connect game board model
    """
    def __init__(self, board: str):
        """
            Construct a Board from the given string representation.
        """
        self.rows = [r.strip().split() for r in board.splitlines()]

    def __getitem__(self, row: int) -> list[str]:
        """
            Get the board row for the given row index.
        """
        return self.rows[row]
    
    @property
    def height(self) -> int:
        """
            The board height.
        """
        return len(self.rows)
    
    @property
    def width(self) -> int:
        """
            The board width.
        """
        return len(self.rows[0])

    def get_adjacent_positions(self, row: int, column: int) -> Iterable[tuple[int, int]]:
        """
            Get the adjacent positions within the board boundaries for the given row and column.
        """
        offsets = ((0, -1), (-1, 0), (-1, 1), (0, 1), (1, 0), (1, -1))
        positions = ((row + dr, column + dc) for dr, dc in offsets)
        return ((r, c) for r, c in positions if 0 <= r < self.height and 0 <= c < self.width)

    def is_at_last_row(self, row: int, _column: int) -> bool:
        """
            Returns true if the given row and column is in the last row of the board.
        """
        return row == self.height - 1
    
    def is_at_last_column(self, _row: int, column: int) -> bool:
        """
            Returns true if the given row and column is in the last column on the board.
        """
        return column == self.width - 1


class Pathfinder:
    """
        A pathfinder helper.
    """
    def __init__(self, board: Board, player: str, target_reached: Callable[[int, int], bool]):
        """
            Construct a Pathfinder object with the given board, player, and target_reached callable.
        """
        self.board = board
        self.player = player
        self.target_reached = target_reached
        self.visited = set()

    def path_exists(self, row: int, column: int) -> bool:
        """
            Returns true if there is a path from the given row and column to a position that satisfies
            the target_reached callable given in the __init__ method.
        """
        if self.target_reached(row, column):
            return True
        self.visited.add((row, column))
        return any(
            self.path_exists(r, c)
            for r, c in self.board.get_adjacent_positions(row, column)
            if (r, c) not in self.visited and self.board[r][c] == self.player
        )
