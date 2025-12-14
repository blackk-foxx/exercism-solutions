pub fn factors(n: u64) -> Vec<u64> {
    let mut number = n;
    let mut factors = 2..;
    let mut result = Vec::new();
    while number > 1 {
        let f = factors.next().unwrap();
        while number % f == 0 {
            result.push(f);
            number /= f;
        }
    }
    result
}
