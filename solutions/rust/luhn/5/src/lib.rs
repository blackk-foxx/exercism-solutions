/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    let canonical = code.chars().filter(|c| !c.is_whitespace());
    get_checksum_and_length(canonical)
        .is_some_and(|(checksum, length)| checksum % 10 == 0 && length > 1)
}

fn get_checksum_and_length<T: DoubleEndedIterator<Item = char>>(chars: T) 
    -> Option<(usize, usize)> {
    chars.rev().try_fold((0, 0), |(result, i), c| c.to_digit(10)
        .map(|d| d as usize * (1 + i % 2))
        .map(|d| if d > 9 { d - 9 } else { d })
        .map(|d| (result + d, i + 1)))
}
