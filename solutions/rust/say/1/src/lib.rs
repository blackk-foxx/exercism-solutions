const ONES_AND_TEENS: [&str; 20] = [
    "",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen"
];

const TENS: [&str; 10] = [
    "",
    "ten",
    "twenty",
    "thirty",
    "forty",
    "fifty",
    "sixty",
    "seventy",
    "eighty",
    "ninety"
];

const THOUSANDS_POWERS: [&str; 7] = [
    "",
    "thousand",
    "million",
    "billion",
    "trillion",
    "quadrillion",
    "quintillion"
];

pub fn encode(n: u64) -> String {
    if n == 0 { "zero".to_owned() }
    else { encode_nonzero(n) }
}

fn encode_nonzero(n: u64) -> String {
    match n as usize {
        i if i < ONES_AND_TEENS.len() => ONES_AND_TEENS[i].to_owned(),
        i if i < 100 => TENS[i / 10].to_owned() + &suffix(n, 10, "-"),
        i if i < 1_000 => encode_with_scale(n, 100, "hundred"),
        _ => encode_big_number(n)
    }
}

fn encode_big_number(n: u64) -> String {
    let order = n.ilog(1_000);
    if let Some(scale) = THOUSANDS_POWERS.get(order as usize) {
        encode_with_scale(n, 1_000u64.pow(order), scale)
    }
    else {
        "nada".to_owned()
    }
}

fn encode_with_scale(n: u64, divisor: u64, scale: &str) -> String {
    encode_nonzero(n / divisor) + " " + scale + &suffix(n, divisor, " ")
}

fn suffix(n: u64, divisor: u64, separator: &str) -> String {
    let remainder = n % divisor;
    let prefix = if remainder > 0 { separator } else { "" };
    prefix.to_owned() + &encode_nonzero(n % divisor)
}