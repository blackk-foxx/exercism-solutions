use regex_lite::{Captures, Regex};

pub fn translate(input: &str) -> String {
    input.split(" ").map(translate_word).collect::<Vec<_>>().join(" ")
}

fn translate_word(word: &str) -> String {
    let xr_yt_rule = Regex::new("^(xr|yt).*").unwrap();
    let qu_rule = Regex::new("^([^aeiouq]*qu)(.*)").unwrap();
    let leading_consonants_rule = Regex::new("^([^aeiou]+)([aeiouy].*)").unwrap();
    let base = 
        if xr_yt_rule.is_match(word) {
            word.to_owned()
        }
        else if let Some(captures) = qu_rule.captures(word) {
            swap_groups(captures)
        }
        else if let Some(captures) = leading_consonants_rule.captures(word) {
            swap_groups(captures)
        }
        else {
            word.to_owned()
        };
    base + "ay"
}

fn swap_groups(captures: Captures) -> String {
    let (_, [head, tail]) = captures.extract();
    tail.to_owned() + head
}