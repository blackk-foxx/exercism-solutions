// The code below is a stub. Just enough to satisfy the compiler.
// In order to pass the tests you can add-to or change any of this code.

#[derive(Debug)]
pub struct Duration {
    seconds: f64
}

impl From<u64> for Duration {
    fn from(s: u64) -> Self {
        Duration{seconds: s as f64}
    }
}

pub trait Planet {
    fn years_during(d: &Duration) -> f64 {
        todo!("convert a duration ({d:?}) to the number of years on this planet for that duration");
    }
}

const HOURS_PER_DAY: f64 = 24.0;
const DAYS_PER_YEAR: f64 = 365.25;
const HOURS_PER_YEAR: f64 = HOURS_PER_DAY * DAYS_PER_YEAR;
const MINUTES_PER_YEAR: f64 = 60.0 * HOURS_PER_YEAR;
const SECONDS_PER_YEAR: f64 = 60.0 * MINUTES_PER_YEAR;

pub struct Mercury;
pub struct Venus;
pub struct Earth;
pub struct Mars;
pub struct Jupiter;
pub struct Saturn;
pub struct Uranus;
pub struct Neptune;

macro_rules! gen_planets {
    ($($planet:ty : $period:literal),*) => {
        $(impl Planet for $planet {
            fn years_during(d: &Duration) -> f64 {
                d.seconds / SECONDS_PER_YEAR / $period
            }
        })*
    }
}

gen_planets!(
    Mercury: 0.2408467, Venus: 0.6151972, Earth: 1.0, Mars: 1.8808158, 
    Jupiter: 11.862615, Saturn: 29.447498, Uranus: 84.016846, Neptune: 164.79132
);
