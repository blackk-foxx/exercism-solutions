pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    let mut result = Vec::new();
    let upper_bound_plus_one = upper_bound as usize + 1;
    let mut sieve = vec![0; upper_bound_plus_one];
    for factor in 2..upper_bound_plus_one {
        if sieve[factor] == 0 {
            result.push(factor as u64);
            for multiple in (factor..upper_bound_plus_one).step_by(factor) {
                sieve[multiple] = 1;
            }
        }
    }
    result
}
