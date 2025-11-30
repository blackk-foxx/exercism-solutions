import itertools

class Scale:

    NATURALS_WITH_SHARP = "ACDFG"
    NATURALS_WITH_FLAT = "ABDEG"

    CHROMATIC_LENGTH = 12
    
    # TODO: Generate the sharp keys via the circle of 5ths
    SHARP_KEYS = {"C", "G", "D", "A", "E", "B", "F#", "a", "e", "b", "f#", "c#", "g#", "d#"}

    def __init__(self, key):
        self.key = key

    def chromatic(self):
        tonic = self.major(self.key)
        next_note_fn = self.next_sharp if self.key in self.get_sharp_keys() else self.next_flat
        generator = self.generate_chromatic(tonic, next_note_fn)
        return list(itertools.islice(generator, self.CHROMATIC_LENGTH))

    def get_sharp_keys(self):
        return set(self.generate_major_sharp_keys()) | set(self.generate_minor_sharp_keys())
        
    def generate_major_sharp_keys(self):
        key = 'C'
        for i in range(7):
            yield key
            for i in range(7):
                key = self.next_sharp(key)

    def generate_minor_sharp_keys(self):
        key = 'a'
        for i in range(7):
            yield key
            major = self.major(key)
            for i in range(7):
                major = self.next_sharp(major)
            key = self.minor(major)

    @staticmethod
    def major(note):
        return note[0].upper() + (note[1] if len(note) > 1 else '')

    @staticmethod
    def minor(note):
        return note[0].lower() + (note[1] if len(note) > 1 else '')

    def generate_chromatic(self, tonic, next_note_fn):
        note = tonic
        while True:
            yield note
            note = next_note_fn(note)

    def next_sharp(self, note):
        natural = note[0]
        modifier = '#' if len(note) > 1 else ''
        if modifier:
            natural = self.next_natural(natural)
            modifier = ''
        else:
            if natural in self.NATURALS_WITH_SHARP:
                modifier = '#'
            else:
                natural = self.next_natural(natural)
        return natural + modifier

    def next_flat(self, note):
        natural = note[0]
        modifier = 'b' if len(note) > 1 else ''
        if modifier:
            modifier = ''
        else:
            natural = self.next_natural(natural)
            if natural in self.NATURALS_WITH_FLAT:
                modifier = 'b'
        return natural + modifier

    @staticmethod
    def next_natural(natural):
        result = chr(ord(natural) + 1)
        if result == 'H':
            result = 'A'
        return result
        
    def interval(self, intervals):
        chromatic = self.chromatic()
        return [chromatic[j] for j in self.generate_indices(intervals)]

    def generate_indices(self, intervals):
        index = 0
        yield index
        for i in intervals:
            index += {"m": 1, "M": 2, "A": 3}[i]
            if index >= self.CHROMATIC_LENGTH:
                index = index - self.CHROMATIC_LENGTH
            yield index
