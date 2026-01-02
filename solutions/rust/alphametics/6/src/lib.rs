use itertools::Itertools;
use std::collections::HashMap;
use std::collections::HashSet;
use std::iter::zip;

pub fn solve(input: &str) -> Option<HashMap<char, u8>> {
    let (formula, symbolic_sum) = input.split_once(" == ")?;
    let addends = formula.split(" + ").collect::<Vec<_>>();
    let letters = get_letters(input);
    let digits: [u8; 10] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    for perm in digits.into_iter().permutations(letters.len()) {
        let mapping = create_mapping(&letters, &perm);
        if mapping_resolves(&mapping, &addends, symbolic_sum) {
            return Some(mapping);
        }
    }
    None
}

fn get_letters(input: &str) -> HashSet<char> {
    input
        .chars()
        .filter(|c| c.is_alphabetic())
        .collect()
}

fn create_mapping(letters: &HashSet<char>, digits: &Vec<u8>) -> HashMap<char, u8> {
    zip(letters.iter(), digits)
        .map(|(&c, &n)| (c, n))
        .collect()
}

fn mapping_resolves(mapping: &HashMap<char, u8>, addends: &Vec<&str>, symbolic_sum: &str) -> bool {
    mapping_is_valid(mapping, addends, symbolic_sum) &&
    addends
        .iter()
        .fold(0, |acc, &a| acc + make_numeric(mapping, a))
            == make_numeric(mapping, symbolic_sum)
}

fn mapping_is_valid(mapping: &HashMap<char, u8>, addends: &Vec<&str>, symbolic_sum: &str) -> bool {
    get_key_for_value(mapping, 0).is_none_or(|zero_mapped_char| 
        !symbolic_sum.starts_with(zero_mapped_char) &&
        !addends
            .iter()
            .any(|&a| a.starts_with(zero_mapped_char))
    )
}

fn get_key_for_value(mapping: &HashMap<char, u8>, value: u8) -> Option<char> {
    mapping
        .iter()
        .find(|(_, v)| **v == value)
        .map(|(k, _)| *k)
}

fn make_numeric(mapping: &HashMap<char, u8>, term: &str) -> u32 {
    term
        .chars()
        .filter_map(|c| mapping.get(&c))
        .fold(0, |acc, &digit| acc * 10 + digit as u32)
}
