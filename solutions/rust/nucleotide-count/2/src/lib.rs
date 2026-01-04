use std::collections::HashMap;

pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    nucleotide_counts(dna)?
        .get(&nucleotide)
        .ok_or(nucleotide)
        .copied()
}

pub fn nucleotide_counts(dna: &str) -> Result<HashMap<char, usize>, char> {
    let mut result = HashMap::from_iter("ACGT".chars().map(|c| (c, 0)));
    for c in dna.chars() {
        match result.get_mut(&c) {
            Some(n) => *n += 1,
            None => return Err(c),
        }
    };
    Ok(result)
}
