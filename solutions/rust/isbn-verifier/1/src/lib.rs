/// Determines whether the supplied string is a valid ISBN number
pub fn is_valid_isbn(isbn: &str) -> bool {
    let digits = isbn.chars().filter(|&c| c != '-');
    let first_nine = digits.clone().take(9);
    let check_digit = digits.clone().nth(9);
    digits.count() == 10 &&
    check_digit_value(check_digit).is_some_and(|check_value|
        (checksum(first_nine) + check_value) % 11 == 0
    )
}

fn checksum(digits: impl Iterator<Item = char>) -> u32 {
    digits
        .filter_map(|digit| digit.to_digit(10))
        .enumerate()
        .map(|(index, value)| (value, (10 - index as u32)))
        .fold(0, |acc, (value, multiplier)| acc + value * multiplier)
}

fn check_digit_value(check_digit: Option<char>) -> Option<u32> {
    match check_digit? {
        'X' => Some(10),
        d => d.to_digit(10),
    }
}
