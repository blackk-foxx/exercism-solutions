use std::collections::HashSet;
use std::collections::HashMap;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let target_lowercase = word.to_lowercase();
    let target_count_for_char = count_for_char(&target_lowercase);
    let is_anagram = |x: &str| {
        x.to_lowercase() != target_lowercase &&
        count_for_char(&x.to_lowercase()) == target_count_for_char
    };
    possible_anagrams.iter().filter(|x| is_anagram(x)).copied().collect()
}

fn count_for_char(word: &str) -> HashMap<char, i32> {
    let mut result = HashMap::<char, i32>::new();
    for c in word.chars() {
        result.entry(c).and_modify(|count| *count += 1).or_insert(1);
    }
    result
}
