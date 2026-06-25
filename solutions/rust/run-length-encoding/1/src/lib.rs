use std::iter;

pub fn encode(source: &str) -> String {
    let mut result = String::new();
    let mut chars = source.chars();
    if let Some(mut current_char) = chars.next() {
        let mut count = 1;
        chars.for_each(|c| {
            if c == current_char {
                count += 1
            }
            else {
                result += &encode_run(count, current_char);
                current_char = c;
                count = 1;
            }
        });
        result += &encode_run(count, current_char);
    }
    result
}

pub fn encode_run(count: i32, c: char) -> String {
    let prefix = if count > 1 { &count.to_string() } else { "" };
    format!("{}{}", prefix, c)
}

pub fn decode(source: &str) -> String {
    let mut result = String::new();
    let mut count = String::new();
    source.chars().for_each(|c| {
        if c.is_ascii_digit() {
            count.push(c);
        }
        else {
            let run_length = count.parse::<usize>().unwrap_or(1);
            result += &iter::repeat_n(c, run_length).collect::<String>();
            count.clear();
        }
    });
    result
}
