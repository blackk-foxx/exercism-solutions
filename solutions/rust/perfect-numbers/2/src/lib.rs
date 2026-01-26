#[derive(Debug, PartialEq, Eq)]
pub enum Classification {
    Abundant,
    Perfect,
    Deficient,
}

pub fn classify(num: u64) -> Option<Classification> {
    (num > 0).then_some(
        match aliquot_sum(num) {
            s if num < s => Classification::Abundant,
            s if num == s => Classification::Perfect,
            _ => Classification::Deficient,
        }
    )
}

fn aliquot_sum(num: u64) -> u64 {
    (1..=(num / 2)).filter(move |&n| num.is_multiple_of(n)).sum()
}
