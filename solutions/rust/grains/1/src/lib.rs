pub fn square(s: u32) -> u64 {
    let base: u64 = 2;
    base.pow(s - 1)
}

pub fn total() -> u64 {
    let square_nums = (1..=64);
    square_nums.fold(0, |acc, s| acc + square(s))
}
