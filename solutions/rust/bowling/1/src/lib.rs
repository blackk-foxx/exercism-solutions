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
        if pins > 10 {
            return Err(Error::NotEnoughPinsLeft);
        }
        if self.game_is_complete() {
            return Err(Error::GameComplete);
        }
        self.rolls.push(pins);
        if !self.last_roll_is_valid() {
            return Err(Error::NotEnoughPinsLeft);
        }
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
                    .map(|frame| 
                        if self.is_strike(frame) || self.is_spare(frame) {
                            (frame, 3)
                        }
                        else {
                            (frame, 2)
                        }
                    )
                    .map(|(frame, roll_count)| self.sum_of_roll_range(frame, 0, roll_count - 1))
                    .sum();
            Some(result)
        }
    }

    fn advance_to_next_frame(&mut self) -> () {
        self.first_roll_index_in_frame.push(self.rolls.len());
    }

    fn game_is_complete(&self) -> bool {
        self.frame_count() == 10
    }

    fn last_roll_is_valid(&self) -> bool {
        let frame = self.frame_count();
        if frame == 9 {
            if self.sum_of_roll_range(frame, 0, 1) == 20 {
                if self.sum_of_roll_range(frame, 2, 2) > 10 {
                    return false;
                }
            }
            else if self.sum_of_roll_range(frame, 0, 0) == 10 {
                if self.sum_of_roll_range(frame, 1, 2) > 10 {
                    return false;
                }
            }
        }
        if self.last_roll_ends_current_frame() {
            if frame < 9 && self.sum_of_roll_range(frame, 0, 1) > 10 {
                return false;
            }
        }
        true
    }
    
    fn sum_of_roll_range(&self, frame: usize, starting_roll: usize, ending_roll: usize) -> u16 {
        let first_roll_index = self.first_roll_index_in_frame[frame];
        (starting_roll..=ending_roll).filter_map(
            |roll_index| self.rolls.get(first_roll_index + roll_index)
        ).sum()
    }

    fn frame_count(&self) -> usize {
        self.first_roll_index_in_frame.len() - 1
    }

    fn last_roll_ends_current_frame(&self) -> bool {
        let max_roll_count = 2;
        let current_frame = self.frame_count();
        if self.current_frame_is_final() {
            let bonus = (self.is_strike(current_frame) || self.is_spare(current_frame)) as usize;
            self.roll_count_in_current_frame() == max_roll_count + bonus
        }
        else {
            self.is_strike(current_frame) || self.roll_count_in_current_frame() == max_roll_count
        }
    }

    fn current_frame_is_final(&self) -> bool {
        self.frame_count() == 9
    }

    fn roll_count_in_current_frame(&self) -> usize {
        self.rolls.len() - self.first_roll_index_in_frame.last().unwrap()
    }

    fn is_spare(&self, frame: usize) -> bool {
        self.sum_of_roll_range(frame, 0, 1) == 10
    }

    fn is_strike(&self, frame: usize) -> bool {
        self.sum_of_roll_range(frame, 0, 0) == 10
    }
}
