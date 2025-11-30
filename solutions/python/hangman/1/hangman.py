# Game status categories
# Change the values as you see fit
STATUS_WIN = 'win'
STATUS_LOSE = 'lose'
STATUS_ONGOING = 'ongoing'


class Hangman:
    def __init__(self, word):
        self.remaining_guesses = 9
        self.status = STATUS_ONGOING
        self.word = word
        self.masked_word = ["_"] * len(word)

    def guess(self, char):
        if self.status != STATUS_ONGOING:
            raise ValueError("The game has already ended.")
        self.handle_guess(char)

    def handle_guess(self, char):
        if char in self.masked_word:
            self.remaining_guesses -= 1
        else:
            if char in self.word:
                self.handle_good_guess(char)
            else:
                self.remaining_guesses -= 1
        if self.remaining_guesses < 0:
            self.status = STATUS_LOSE

    def handle_good_guess(self, char):
        for i, c in enumerate(self.word):
            if c == char:
                self.masked_word[i] = char
        if "_" not in self.masked_word:
            self.status = STATUS_WIN

    def get_masked_word(self):
        return ''.join(self.masked_word)

    def get_status(self):
        return self.status
