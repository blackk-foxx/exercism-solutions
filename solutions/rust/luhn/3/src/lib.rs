/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    let canonical = code.chars().filter(|c| !c.is_whitespace());
    get_checksum(canonical).map_or(false, |n| n % 10 == 0)
}

fn get_checksum<T: DoubleEndedIterator<Item = char>>(chars: T) -> Option<usize> {
    let(checksum, length) = chars
        .rev()
        .try_fold((0, 0), |(result, i), c| c.to_digit(10)
                 .map(|d| transform(d, 1 + i % 2))
                 .map(|d| (result + d, i + 1)))?;
    if length > 1 {Some(checksum)} else {None}
}

fn transform(digit: u32, multiplier: usize) -> usize {
    let result = digit as usize * multiplier;
    if result > 9 { result - 9 } else { result }
}
