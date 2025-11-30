def spiral_matrix(size):
    matrix = SpiralMatrix(size)
    matrix.populate()
    return matrix.rows


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
        self.rows = [[None] * size for i in range(size)]
        self.size = size

    def populate(self):
        i, j = 0, 0
        for value in range(1, self.size * self.size + 1):
            self.rows[i][j] = value
            i, j = self.get_next_indices(i, j)

    def get_next_indices(self, i, j):
        next_i, next_j = self.offsets.apply(i, j)
        if self.need_offsets_shift(next_i, next_j):
            self.offsets.shift()
            next_i, next_j = self.offsets.apply(i, j)
        return next_i, next_j

    def need_offsets_shift(self, i, j):
        return (
            not 0 <= i < self.size or
            not 0 <= j < self.size or
            self.rows[i][j] is not None
        )
