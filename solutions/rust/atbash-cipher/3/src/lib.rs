fn encode_char(c: char) -> char {
    if c.is_alphabetic()
        {(b'a' + b'z' - c as u8) as char}
    else 
        {c}
}

fn insert_spaces_every_n<I>(iter: I, n: usize) -> impl Iterator<Item = char>
    where I: Iterator<Item = char> {
    iter
        .enumerate()
        .flat_map(|(i, c)| {
            (i != 0 && i % 5 == 0).then_some(' ')
            .into_iter()
            .chain(std::iter::once(c))
        })
        .into_iter()
}

/// "Encipher" with the Atbash cipher.
pub fn encode(plain: &str) -> String {
    let encoded = plain.chars()
        .filter(|c| { c.is_alphabetic() || c.is_numeric() })
        .filter_map(|c| { c.to_lowercase().next() })
        .map(|c| { encode_char(c) });

    insert_spaces_every_n(encoded, 5).collect()
}

/// "Decipher" with the Atbash cipher.
pub fn decode(cipher: &str) -> String {
    cipher.chars().filter_map(
        |c| { (c != ' ').then_some(encode_char(c)) }
    ).collect()
}
