"""
    Bowling exercise solution.
"""

class BowlingGame:
    """
        Tracks a player's rolls and provides the score when the game is complete.
    """
    def __init__(self):
        self.rolls = []
        self.frame_indices = [0]

    def roll(self, pins):
        """
            Add a roll with a given number of pins knocked down.
        """
        if self._game_is_over():
            raise ValueError("Cannot roll more than ten frames")
        self._validate_roll(pins)
        self.rolls.append(pins)
        if not self._in_last_frame() and self._last_roll_ended_frame():
            self.frame_indices.append(len(self.rolls))

    def score(self):
        """
            Calculate the final score.
        """
        if not self._game_is_over():
            raise ValueError("Cannot calculate score until game is over")
        return sum(
            self._frame_score(frame)
            for frame in range(10)
        )

    def _game_is_over(self):
        if self._in_last_frame():
            frame_rolls = self._rolls_in_frame(9)
            if len(frame_rolls) == 3 or len(frame_rolls) == 2 and sum(frame_rolls) < 10:
                return True
        return False

    def _validate_roll(self, pins):
        if not 0 <= pins <= 10:
            raise ValueError("Roll must be between zero and ten")
        if self._in_last_frame():
            self._validate_last_frame_roll(pins)
        elif self._roll_count_in_current_frame() == 1 and self.rolls[-1] + pins > 10:
            raise ValueError("Cannot roll more than ten in a frame")

    def _validate_last_frame_roll(self, pins):
        frame_rolls = [*self._rolls_in_frame(9), pins]
        if len(frame_rolls) > 1:
            if sum(frame_rolls[:2]) in {10, 20} and len(frame_rolls) == 3:
                pass
            elif frame_rolls[0] == 10 and sum(frame_rolls[1:]) > 10:
                raise ValueError("Cannot roll more than ten bonus pins")

    def _in_last_frame(self):
        return len(self.frame_indices) == 10

    def _last_roll_ended_frame(self):
        return self.rolls[-1] == 10 or self._roll_count_in_current_frame() == 2

    def _roll_count_in_current_frame(self):
        return len(self.rolls) - self.frame_indices[-1]

    def _rolls_in_frame(self, frame):
        first, last = self._frame_bounds(frame)
        return self.rolls[first:last]

    def _frame_score(self, frame):
        first, last = self._frame_bounds(frame)
        base_score = sum(self.rolls[first:last])
        if base_score == 10:
            bonus_roll_count = 3 - (last - first)
            return base_score + sum(self.rolls[last:last+bonus_roll_count])
        return base_score

    def _frame_bounds(self, frame):
        first = self.frame_indices[frame]
        try:
            last = self.frame_indices[frame + 1]
        except IndexError:
            last = len(self.rolls)
        return first, last
