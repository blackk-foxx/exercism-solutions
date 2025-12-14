pub fn factors(n: u64) -> Vec<u64> {
    let mut number = n;
    let mut factor = 2;
    let mut result = Vec::new();
    while number > 1 {
        while number % factor == 0 {
            result.push(factor);
            number /= factor;
        }
        factor += 1;
    }
    result
}
