use itertools::Itertools;
use std::collections::HashSet;
use std::iter::zip;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Palindrome {
    value: u64,
    first_factor_pair: (u64, u64)
}

impl Palindrome {
    pub fn value(&self) -> u64 {
        self.value
    }

    pub fn into_factors(&self) -> HashSet<(u64, u64)> {
        let (f0, f1) = self.first_factor_pair;
        let mut factors: HashSet<(u64, u64)> = HashSet::from([(f0, f1)]);
        factors.extend(find_factor_pairs(self.value, (f0 + 1)..f1));
        factors
    }
}

pub fn palindrome_products(min: u64, max: u64) -> Option<(Palindrome, Palindrome)> {
    let ascending_products = (min * min)..=(max * max);
    let descending_products = ascending_products.clone().rev();
    let smallest_palindrome = find_first_palindrome(ascending_products, min, max);
    let largest_palindrome = find_first_palindrome(descending_products, min, max);

    match (smallest_palindrome, largest_palindrome) {
        (Some(p0), Some(p1)) => Some((p0, p1)),
        _ => None
    }
}

fn find_first_palindrome(products: impl DoubleEndedIterator<Item = u64>, min_factor: u64, max_factor: u64) -> Option<Palindrome> {
    for value in products.filter(is_palindrome) {
        if let Some(first_factor_pair) = find_first_factor_pair(value, min_factor, max_factor) {
            return Some(Palindrome {value, first_factor_pair})
        }
    }
    None
    
    /*
    * Alternative implementation
    * Pro: more functional
    * Con: harder to read, uses unwrap
    products
        .filter(is_palindrome)
        .map(|value| (value, find_first_factor_pair(value, min_factor, max_factor)))
        .find(|(value, first_factor_pair)| first_factor_pair.is_some())
        .map(|(value, first_factor_pair)| Palindrome {value, first_factor_pair: first_factor_pair.unwrap()})

    */
}

fn is_palindrome(n: &u64) -> bool {
    let s = n.to_string();
    let head = &s[0..s.len()/2];
    let tail = &s[s.len()/2..s.len()];
    zip(head.chars(), tail.chars().rev()).all(|(c1, c2)| c1 == c2)
}

fn find_first_factor_pair(n: u64, min_factor: u64, max_factor: u64) -> Option<(u64, u64)> {
    find_all_factors(n, min_factor..=max_factor)
        .map(|x| (x, n / x))
        .find(|(_, y)| min_factor <= *y && *y <= max_factor)
}

fn find_factor_pairs(n: u64, factors: impl Iterator<Item = u64>) -> impl Iterator<Item = (u64, u64)> {
    factors
        .combinations_with_replacement(2)
        .map(|combo| (combo[0], combo[1]))
        .filter(move |(a, b)| a * b == n)
}

fn find_all_factors(n: u64, factors: impl Iterator<Item = u64>) -> impl Iterator<Item = u64> {
    factors.filter(move |x| n % x == 0)
}
