use std::iter::zip;

/// Return the Hamming distance between the strings,
/// or None if the lengths are mismatched.
pub fn hamming_distance(s1: &str, s2: &str) -> Option<usize> {
    (s1.len() == s2.len()).then_some(
        zip(s1.chars(), s2.chars())
            .filter(|(c1, c2)| c1 != c2)
            .count()
    )
}
