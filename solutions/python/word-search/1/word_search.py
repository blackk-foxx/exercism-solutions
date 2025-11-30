import itertools

class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def translate(self, dx, dy, multiplier):
        return Point(self.x + dx * multiplier, self.y + dy * multiplier)


class WordSearch:
    def __init__(self, puzzle):
        self.puzzle = puzzle
        self.height = len(puzzle)
        self.width = len(puzzle[0])

    def search(self, word):
        for x, y in itertools.product(range(self.width), range(self.height)):
            for dx, dy in itertools.product(range(-1, 2), range(-1, 2)):
                if self.word_is_at(Point(x, y), word, (dx, dy)):
                    return (Point(x, y), Point(x, y).translate(dx, dy, len(word) - 1))

    def word_is_at(self, starting_point, word, direction):
        sequence = self.get_char_sequence(starting_point, direction)
        try:
            for c in word:
                if c != next(sequence):
                    return False
            return True
        except (IndexError, StopIteration):
            return False

    def get_char_sequence(self, starting_point, direction):
        dx, dy = direction
        point = starting_point
        while point.x >= 0 and point.y >= 0:
            yield self.puzzle[point.y][point.x]
            point = point.translate(dx, dy, 1)
