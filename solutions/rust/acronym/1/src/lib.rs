pub fn abbreviate(phrase: &str) -> String {
    let mut result: Vec<char> = Vec::new();
    let mut last_char: char = ' ';
    for c in phrase.chars() {
        if c == '_' { continue }
        if (last_char == ' ' || last_char == '-') && c.is_alphabetic() {
            result.extend(c.to_uppercase());
        }
        else if last_char.is_lowercase() && c.is_uppercase() {
            result.push(c);
        }
        last_char = c;
    }
    result.into_iter().collect()
}
