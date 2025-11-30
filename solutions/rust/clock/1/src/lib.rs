#[derive(Debug)]
pub struct Clock {
    hours: i32,
    minutes: i32,
}

use std::fmt;

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        Clock {hours, minutes}.resolve()
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Clock {hours: self.hours, minutes: self.minutes + minutes}.resolve()
    }

    fn resolve(&self) -> Self {
        let mut net_minutes = self.minutes % 60;
        let total_hours = self.hours + self.minutes / 60;
        let mut net_hours = total_hours % 24;
        if net_minutes < 0 {
            net_minutes += 60;
            net_hours -= 1;
        }
        if net_hours < 0 {
            net_hours += 24;
        }
        Clock {hours: net_hours, minutes: net_minutes}
    }
}

impl fmt::Display for Clock {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{:02}:{:02}", self.hours, self.minutes)
    }
}


impl PartialEq for Clock {
    fn eq(&self, other: &Self) -> bool {
        self.hours == other.hours &&
        self.minutes == other.minutes
    }
}
