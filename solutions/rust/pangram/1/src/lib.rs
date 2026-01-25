use std::collections::HashSet;

/// Determine whether a sentence is a pangram.
pub fn is_pangram(sentence: &str) -> bool {
    let letters = sentence
        .chars()
        .filter(|c| c.is_alphabetic())
        .map(|c| c.to_ascii_uppercase());
    HashSet::<char>::from_iter(letters).len() == 26
}
