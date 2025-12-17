pub fn reply(message: &str) -> &str {
    match message {
        m if is_silence(m) => "Fine. Be that way!",
        m if is_yelling(m) && is_question(m) => "Calm down, I know what I'm doing!",
        m if is_yelling(m) => "Whoa, chill out!",
        m if is_question(m) => "Sure.",
        _ => "Whatever."
    }
}

fn is_silence(message: &str) -> bool {
    message.chars().all(|c| c.is_whitespace())
}

fn is_question(message: &str) -> bool {
    message.trim().ends_with('?')
}

fn is_yelling(message: &str) -> bool {
    let letters: Vec<_> = message.chars().filter(|c| c.is_alphabetic()).collect();
    letters.iter().all(|c| c.is_uppercase()) && !letters.is_empty()
}
