pub fn reverse(input: &str) -> String {
    let mut result: String = "".to_string();
    let mut input_iter = input.chars();
    while let Some(c) = input_iter.next_back() {
        result.push(c);
    };
    result
}
