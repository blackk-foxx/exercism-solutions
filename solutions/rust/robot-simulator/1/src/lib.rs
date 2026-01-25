// The code below is a stub. Just enough to satisfy the compiler.
// In order to pass the tests you can add-to or change any of this code.
use enum_iterator::{next_cycle, previous_cycle, Sequence};

#[derive(PartialEq, Eq, Debug, Sequence)]
pub enum Direction {
    North,
    East,
    South,
    West,
}

pub struct Robot {
    position: (i32, i32),
    bearing: Direction
}

impl Robot {
    pub fn new(x: i32, y: i32, d: Direction) -> Self {
        Robot { position: (x, y), bearing: d }
    }

    #[must_use]
    pub fn turn_right(self) -> Self {
        Robot { position: self.position, bearing: next_cycle(&self.bearing) }
    }

    #[must_use]
    pub fn turn_left(self) -> Self {
        Robot { position: self.position, bearing: previous_cycle(&self.bearing) }
    }

    #[must_use]
    pub fn advance(self) -> Self {
        let offset = match self.bearing {
            Direction::North => (0, 1),
            Direction::East => (1, 0),
            Direction::South => (0, -1),
            Direction::West => (-1, 0)
        };
        Robot { 
            position: (self.position.0 + offset.0, self.position.1 + offset.1), 
            bearing: self.bearing 
        }
    }

    #[must_use]
    pub fn instructions(self, instructions: &str) -> Self {
        instructions
            .chars()
            .fold(self, |acc, c| match c {
                'A' => acc.advance(),
                'L' => acc.turn_left(),
                'R' => acc.turn_right(),
                _ => acc
            })
    }

    pub fn position(&self) -> (i32, i32) {
        self.position
    }

    pub fn direction(&self) -> &Direction {
        &self.bearing
    }
}
