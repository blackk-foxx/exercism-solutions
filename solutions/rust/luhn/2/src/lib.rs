/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    let canonical = code.chars().filter(|c| *c != ' ');
    match get_luhn_sum(canonical) {
        Some(n) => n % 10 == 0,
        None => false
    }
}

fn get_luhn_sum<T: DoubleEndedIterator<Item = char>>(chars: T) -> Option<usize> {
    let (checksum, len) = chars.rev()
        .try_fold((0, 0), |(result, i), c| c.to_digit(10)
            .map(|d| {
                let multiplier = 1 + i % 2;
                (result + clip(d as usize * multiplier), i + 1)
            })
        )?;
    if len > 1 {Some(checksum)} else {None}
}

fn clip(n: usize) -> usize {
    if n > 9 { n - 9 } else { n }
}
