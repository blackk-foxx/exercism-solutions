const word_for_number: [&str; 11] = [
    "no",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten"
];

pub fn recite(start_bottles: u32, take_down: u32) -> String {
    let range = (start_bottles - take_down + 1)..(start_bottles + 1);
    range.rev().map(|n| verse(n)).collect::<Vec<String>>().join("\n\n")
}

fn verse(n: u32) -> String {
    let result = [
        format!("{} hanging on the wall,", capitalize(&object(n))),
        format!("{} hanging on the wall,", capitalize(&object(n))),
        format!("And if {} should accidentally fall,", &object(1)),
        format!("There'll be {} hanging on the wall.", &object(n-1))
    ];
    result.join("\n")
}

fn object(n: u32) -> String {
    let suffix = if n == 1 { "" } else { "s" };
    word_for_number[n as usize].to_string() + " green bottle" + suffix 
}

fn capitalize(s: &str) -> String {
    let mut chars = s.chars();
    match chars.next() {
        None => String::new(),
        Some(first_char) => {
            first_char.to_uppercase()
                      .chain(chars)
                      .collect()
        }
    }
}