pub fn reverse(input: &str) -> String {
    let mut result: String = "".to_string();
    let mut input_iter = input.chars();
    while match input_iter.next_back() {
        Some(c) => {result.push(c); true},
        None => false,
    }{
    };
    result
}
