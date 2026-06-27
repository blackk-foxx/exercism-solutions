use std::fmt::{Display, Formatter, Result};

pub struct Roman {
    num: u32
}

const TENS: [&str; 4] = ["I", "X", "C", "M"];

const FIVES: [&str; 3] = ["V", "L", "D"];

impl Roman {
    fn _representation(&self, exp: usize) -> (&str, &str, u32) {
        let power = 10_u32.pow(exp as u32);
        match self.num {
            n if 9 * power <= n => (TENS[exp], TENS[exp + 1], 9 * power),
            n if 5 * power <= n => (FIVES[exp], "", 5 * power),
            n if 4 * power <= n => (TENS[exp], FIVES[exp], 4 * power),
            _ => (TENS[exp], "", power)
        }
    }    
}

impl Display for Roman {
    fn fmt(&self, _f: &mut Formatter<'_>) -> Result {
        if self.num > 0 {
            let exp = self.num.ilog10() as usize;
            let (first, second, amount_represented) = self._representation(exp);
            let remaining = Roman::from(self.num - amount_represented);
            return write!(_f, "{}{}{}", first, second, remaining);
        }
        Ok(())
    }
}

impl From<u32> for Roman {
    fn from(num: u32) -> Self {
        Roman { num }
    }
}
