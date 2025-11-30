import itertools


def get_at(a_list, an_index, default=None):
    try: 
        return a_list[an_index]
    except IndexError: 
        return default


class Scale:

    NATURALS_WITH_SHARP = "ACDFG"
    NATURALS_WITH_FLAT = "ABDEG"
    CHROMATIC_LENGTH = 12
    SEMITONES_IN_FIFTH = 7
    KEY_SET_LENGTH = 7
    
    def __init__(self, key):
        self.key = key

    def chromatic(self):
        tonic = self.to_major(self.key)
        next_note_fn = self.next_sharp if self.key in self.get_sharp_keys() else self.next_flat
        generator = self.generate_chromatic(tonic, next_note_fn)
        return list(itertools.islice(generator, self.CHROMATIC_LENGTH))

    def interval(self, intervals):
        chromatic = self.chromatic()
        return [chromatic[j] for j in self.generate_indices(intervals)]

    def get_sharp_keys(self):
        return (set(itertools.islice(self.generate_fifths('C'), self.KEY_SET_LENGTH)) | 
                set(self.to_minor(key) for key in itertools.islice(self.generate_fifths('A'), self.KEY_SET_LENGTH)))
        
    def generate_fifths(self, starting_key):
        key = starting_key
        while True:
            yield key
            for i in range(self.SEMITONES_IN_FIFTH):
                key = self.next_sharp(key)

    @staticmethod
    def to_major(note):
        return note[0].upper() + get_at(note, 1, '')

    @staticmethod
    def to_minor(note):
        return note[0].lower() + get_at(note, 1, '')

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
        
    def generate_indices(self, intervals):
        index = 0
        yield index
        for i in intervals:
            index += {"m": 1, "M": 2, "A": 3}[i]
            if index >= self.CHROMATIC_LENGTH:
                index = index - self.CHROMATIC_LENGTH
            yield index
