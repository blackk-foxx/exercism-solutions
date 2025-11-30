/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    let canonical = code.chars().filter(|c| *c != ' ');
    match get_luhn_sum(canonical) {
        Some(n) => n % 10 == 0,
        None => false
    }
}

fn get_luhn_sum<T: DoubleEndedIterator<Item = char>>(chars: T) -> Option<usize> {
    let mut result: usize = 0;
    let mut loop_count: usize = 0;
    for (i, c) in chars.rev().enumerate() {
        let multiplier = 1 + i % 2;
        let n = c.to_digit(10)?;
        result += clip(n as usize * multiplier);
        loop_count += 1;
    }
    if loop_count > 1 {
        Some(result)
    }
    else {
        None
    }
}

fn clip(n: usize) -> usize {
    if n > 9 { n - 9 } else { n }
}
