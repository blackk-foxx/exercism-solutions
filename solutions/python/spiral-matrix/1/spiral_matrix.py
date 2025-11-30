def spiral_matrix(size):
    return SpiralMatrix(size).rows

class SpiralMatrix:

    class Offsets:

        offsets = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        def __init__(self):
            self.index = 0

        def apply(self, i, j):
            i_offset, j_offset = self.offsets[self.index]
            return (i + i_offset, j + j_offset)

        def shift(self):
            self.index += 1
            if self.index >= len(self.offsets):
                self.index = 0
            
    
    def __init__(self, size):
        self.offsets = self.Offsets()
        rows = self.initialize(size)
        self.populate(rows, size)
        self.rows = rows

    def initialize(self, size):
        result = []
        for i in range(size):
            result.append([None] * size)
        return result

    def populate(self, rows, size):
        i, j = 0, 0
        for value in range(1, size * size + 1):
            rows[i][j] = value
            i, j = self.get_next_indices(rows, i, j, size)

    def get_next_indices(self, rows, i, j, size):
        next_i, next_j = self.offsets.apply(i, j)
        if self.need_offset_shift(rows, next_i, next_j, size):
            self.offsets.shift()
            next_i, next_j = self.offsets.apply(i, j)
        return next_i, next_j

    def need_offset_shift(self, rows, i, j, size):
        return (
            not 0 <= i < size or
            not 0 <= j < size or
            rows[i][j] is not None
        )
