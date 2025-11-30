fn encode_char(c: char) -> char {
    if c.is_alphabetic()
        {('a' as u8 + 'z' as u8 - c as u8) as char}
    else 
        {c}
}

/*
fn insert_spaces<T: Iterator<Item=char>>(chars: T) -> T {
    chars
        .enumerate()
        .flat_map(|(i, c)| {
            option(i != 0 && i % 5 == 0, ' ')
            .into_iter()
            .chain(std::iter::once(c))
        })
        .into_iter()
}
*/

/// "Encipher" with the Atbash cipher.
pub fn encode(plain: &str) -> String {
    let encoded = plain.chars()
        .filter_map(|c| { (c.is_alphabetic() || c.is_numeric()).then_some(c) })
        .filter_map(|c| { c.to_lowercase().next() })
        .map(|c| { encode_char(c) });

    encoded
        .enumerate()
        .flat_map(|(i, c)| {
            (i != 0 && i % 5 == 0).then_some(' ')
            .into_iter()
            .chain(std::iter::once(c))
        })
        .into_iter()
        .collect()

    //insert_spaces(encoded).collect()
}

/// "Decipher" with the Atbash cipher.
pub fn decode(cipher: &str) -> String {
    cipher.chars().filter_map(
        |c| { (c != ' ').then_some(encode_char(c)) }
    ).collect()
}
