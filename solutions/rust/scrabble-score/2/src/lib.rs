const LETTER_GROUP_SCORES: [(&str, u64); 7] = [
    ("AEIOULNRST", 1),
    ("DG", 2),
    ("BCMP", 3),
    ("FHVWY", 4),
    ("K", 5),
    ("JX", 8),
    ("QZ", 10),
];

/// Compute the Scrabble score for a word.
pub fn score(word: &str) -> u64 {
    word.chars()
        .map(|c| {
            for (group, value) in LETTER_GROUP_SCORES {
                if group.contains(c.to_ascii_uppercase()) {
                    return value;
                }
            }
            0
        })
        .sum()
}
