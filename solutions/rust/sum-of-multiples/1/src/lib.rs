use std::collections::HashSet;

pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    let mut multiples = HashSet::<u32>::new();
    for &f in factors.iter().filter(|&&f| f != 0) {
        (f as usize..limit as usize)
            .step_by(f as usize)
            .for_each(|n| { multiples.insert(n as u32); });
    }
    multiples.iter().sum()
}
