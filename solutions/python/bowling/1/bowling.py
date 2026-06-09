class BowlingGame:
    def __init__(self):
        self.rolls = []
        self.frame_indices = [0]

    def roll(self, pins):
        if self.game_is_over():
            raise ValueError("Cannot roll more than ten frames")
        self.validate_roll(pins)
        self.rolls.append(pins)
        if not self.in_last_frame():
            self.update_frames()

    def update_frames(self):
        first_in_frame = self.frame_indices[-1] == len(self.rolls) - 1
        if self.rolls[-1] == 10 or not first_in_frame:
            self.frame_indices.append(len(self.rolls))

    def in_last_frame(self):
        return len(self.frame_indices) == 10

    def game_is_over(self):
        if self.in_last_frame():
            frame_rolls = self.rolls_in_frame(9)
            if len(frame_rolls) == 2 and sum(frame_rolls) < 10:
                return True
            if len(frame_rolls) == 3:
                return True
        return False

    def validate_roll(self, pins):
        if not 0 <= pins <= 10:
            raise ValueError("Roll must be between zero and ten")
        if self.in_last_frame():
            self.validate_last_frame_roll(pins)
        else:
            if self.next_roll_is_second_in_frame():
                if self.rolls[-1] + pins > 10:
                    raise ValueError("Cannot roll more than ten in a frame")

    def validate_last_frame_roll(self, pins):
        frame_rolls = [*self.rolls_in_frame(9), pins]
        if len(frame_rolls) > 1:
            if sum(frame_rolls[:2]) in (10, 20) and len(frame_rolls) == 3:
                pass
            elif frame_rolls[0] == 10:
                if sum(frame_rolls[1:]) > 10:
                    raise ValueError("Cannot roll more than ten bonus pins")

    def next_roll_is_second_in_frame(self):
        return self.frame_indices[-1] < len(self.rolls)
    
    def score(self):
        if not self.game_is_over():
            raise ValueError("Cannot calculate score until game is over")
        result = 0
        for frame in range(10):
            result += self.frame_score(frame)
        return result

    def rolls_in_frame(self, frame):
        begin, end = self.frame_bounds(frame)
        return self.rolls[begin:end]

    def frame_score(self, frame):
        begin, end = self.frame_bounds(frame)
        base_score = sum(self.rolls[begin:end])
        bonus = 0
        if base_score == 10 and end - begin == 2:
            bonus = self.rolls[end]
        elif base_score == 10 and end - begin == 1:
            bonus = sum(self.rolls[end:end+2])
        return base_score + bonus

    def frame_bounds(self, frame):
        begin = self.frame_indices[frame]
        try:
            end = self.frame_indices[frame + 1]
        except IndexError:
            end = len(self.rolls)
        return begin, end
        
