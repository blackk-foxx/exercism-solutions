pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    let upper_bound = upper_bound as usize;
    let mut result = Vec::new();
    let mut sieve = vec![true; upper_bound + 1];
    for n in 2..=upper_bound {
        if sieve[n] {
            result.push(n as u64);
            for multiple in (n..=upper_bound).step_by(n) {
                sieve[multiple] = false;
            }
        }
    }
    result
}
