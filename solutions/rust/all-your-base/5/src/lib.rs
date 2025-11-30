#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit(u32),
}

///
/// Convert a number between two bases.
///
/// A number is any slice of digits.
/// A digit is any unsigned integer (e.g. u8, u16, u32, u64, or usize).
/// Bases are specified as unsigned integers.
///
/// Return the corresponding Error enum if the conversion is impossible.
///
///
/// You are allowed to change the function signature as long as all test still pass.
///
///
/// Example:
/// Input
///   number: &[4, 2]
///   from_base: 10
///   to_base: 2
/// Result
///   Ok(vec![1, 0, 1, 0, 1, 0])
///
/// The example corresponds to converting the number 42 from decimal
/// which is equivalent to 101010 in binary.
///
///
/// Notes:
///  * The empty slice ( "[]" ) is equal to the number 0.
///  * Never output leading 0 digits, unless the input number is 0, in which the output must be `[0]`.
///    However, your function must be able to process input with leading 0 digits.
///
pub fn convert(digits: &[u32], from_base: u32, to_base: u32) -> Result<Vec<u32>, Error> {
    validate(digits, from_base, to_base).map(|_|
        match value_from_digits(digits, from_base) {
            0 => vec![0],
            v => digits_from_value(v, to_base)
        }
    )
}

fn validate(digits: &[u32], from_base: u32, to_base: u32) -> Result<(), Error> {
    for &d in digits.iter() {
        if d >= from_base { return Err(Error::InvalidDigit(d)) }
    }
    if from_base < 2 {
        return Err(Error::InvalidInputBase)
    }
    if to_base < 2 {
        return Err(Error::InvalidOutputBase)
    }
    Ok(())
}

fn value_from_digits(digits: &[u32], base: u32) -> u32 {
    digits.iter().rev().enumerate().map(|(index, digit)|
        digit * base.pow(index as u32)
    ).sum()
}

fn digits_from_value(value: u32, base: u32) -> Vec<u32> {
    let order = value.ilog(base);
    (0..=order).map(|e| (value / base.pow(e)) % base)
        .rev().collect()
}