use std::collections::HashSet;
use std::collections::HashMap;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    possible_anagrams.iter().filter(|x| is_anagram(x, word)).copied().collect()
}

fn is_anagram(candidate: &str, word: &str) -> bool {
    candidate.to_lowercase() != word.to_lowercase() &&
    count_for_char(candidate.to_lowercase()) == count_for_char(word.to_lowercase())
}

fn count_for_char(word: String) -> HashMap<char, i32> {
    let mut result = HashMap::<char, i32>::new();
    for c in word.chars() {
        result.entry(c).and_modify(|count| *count += 1).or_insert(1);
    }
    result
}
