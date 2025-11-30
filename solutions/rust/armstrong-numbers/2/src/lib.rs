pub fn is_armstrong_number(num: u32) -> bool {
    num == sum_of_powers(get_digits(num))
}

pub fn get_digits(num: u32) -> Vec<u32> {
    let mut result: Vec<u32> = Vec::new();
    let mut remaining = num;
    while remaining > 0 {
        result.push(remaining % 10);
        remaining /= 10;
    }
    result
}

pub fn sum_of_powers(digits: Vec<u32>) -> u32 {
    let exponent = digits.len() as u32;
    digits.iter().map(|n| n.pow(exponent)).sum()
}
