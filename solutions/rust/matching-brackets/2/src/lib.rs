pub fn brackets_are_balanced(string: &str) -> bool {
    let mut stack = Vec::<char>::new();
    for c in string.chars() {
        if ['[', '{', '('].contains(&c) {
            stack.push(c);
        }
        else if [']', '}', ')'].contains(&c) {
            if stack.last() == Some(&opener_for(c)) {
                stack.pop();
            }
            else {
                return false;
            }
        }
    }
    stack.is_empty()
}

fn opener_for(c: char) -> char {
    match c {
        ']' => '[',
        '}' => '{',
        ')' => '(',
        _ => c
    }
}