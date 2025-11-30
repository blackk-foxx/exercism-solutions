use std::collections::HashSet;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let lowercase_word = word.to_lowercase();
    let sorted_word = sorted(&lowercase_word);
    let is_anagram = |x: &str| {
        x.to_lowercase() != lowercase_word && sorted(&x.to_lowercase()) == sorted_word
    };
    possible_anagrams.iter().filter(|x| is_anagram(x)).copied().collect()
}

fn sorted(word: &str) -> Vec<char> {
    let mut result: Vec<char> = word.chars().collect();
    result.sort_unstable();
    result
}
