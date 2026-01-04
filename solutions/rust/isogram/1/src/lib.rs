use std::collections::HashSet;

pub fn check(candidate: &str) -> bool {
    let letters = candidate
        .chars()
        .filter(|c| c.is_alphabetic())
        .flat_map(|c| c.to_lowercase());
    HashSet::<char>::from_iter(letters.clone()).len() == letters.count()
}
