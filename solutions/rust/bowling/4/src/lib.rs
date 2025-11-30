#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    NotEnoughPinsLeft,
    GameComplete,
}

pub struct BowlingGame {
    rolls: Vec<u16>,
    first_roll_index_in_frame: Vec<usize>
}

impl BowlingGame {
    pub fn new() -> Self {
        BowlingGame {
            rolls: Vec::new(),
            first_roll_index_in_frame: [0].to_vec()
        }
    }

    pub fn roll(&mut self, pins: u16) -> Result<(), Error> {
        if self.game_is_complete() {
            return Err(Error::GameComplete);
        }
        if pins > self.current_frame_remaining_pins() {
            return Err(Error::NotEnoughPinsLeft);
        }
        self.rolls.push(pins);
        if self.last_roll_ends_current_frame() {
            self.advance_to_next_frame()
        }
        Ok(())
    }

    pub fn score(&self) -> Option<u16> {
        if self.frame_count() < 10 {
            None
        }
        else {
            let result = 
                (0..10)
                    .map(|frame| self.frame_score(frame))
                    .sum();
            Some(result)
        }
    }

    fn frame_score(&self, frame: usize) -> u16 {
        self.sum_of_rolls(frame, 0..self.rolls_counted_in_score(frame))
    }

    fn current_frame_remaining_pins(&self) -> u16 {
        let frame_sum = self.sum_of_rolls(self.frame_count(), 0..);
        if self.current_frame_is_final() {
            let pins_removed = frame_sum % 10;
            10 - pins_removed
        } else {
            10 - frame_sum
        }
    }

    fn rolls_counted_in_score(&self, frame: usize) -> usize {
        if self.is_strike(frame) || self.is_spare(frame) {
            3
        } else {
            2
        }
    }
    
    fn advance_to_next_frame(&mut self) {
        self.first_roll_index_in_frame.push(self.rolls.len());
    }

    fn game_is_complete(&self) -> bool {
        self.frame_count() == 10
    }

    fn sum_of_rolls(&self, frame: usize, roll_range: impl Iterator<Item = usize>) -> u16 {
        let first_roll_index = self.first_roll_index_in_frame[frame];
        roll_range.map_while(
            |roll_index| self.rolls.get(first_roll_index + roll_index)
        ).sum()
    }

    fn frame_count(&self) -> usize {
        self.first_roll_index_in_frame.len() - 1
    }

    fn last_roll_ends_current_frame(&self) -> bool {
        self.roll_count_in_current_frame() == self.max_rolls_for_current_frame()
    }

    fn max_rolls_for_current_frame(&self) -> usize {
        let current_frame = self.frame_count();
        if self.current_frame_is_final() {
            self.rolls_counted_in_score(current_frame)            
        }
        else {
            if self.is_strike(current_frame) { 1 } else { 2 }
        }
    }

    fn current_frame_is_final(&self) -> bool {
        self.frame_count() == 9
    }

    fn roll_count_in_current_frame(&self) -> usize {
        self.rolls.len() - self.first_roll_index_in_frame.last().unwrap()
    }

    fn is_spare(&self, frame: usize) -> bool {
        self.sum_of_rolls(frame, 0..=1) == 10
    }

    fn is_strike(&self, frame: usize) -> bool {
        self.sum_of_rolls(frame, 0..=0) == 10
    }
}
