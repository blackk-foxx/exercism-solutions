pub fn build_proverb(list: &[&str]) -> String {
    let mut lines: Vec<String> = list
        .windows(2)
        .map(|w| verse(w[0], w[1]))
        .collect();

    if let Some(&first) = list.first() {
        lines.push(ending(first));
    }

    lines.join("\n")
}

fn verse(first: &str, second: &str) -> String {
    format!("For want of a {0} the {1} was lost.", first, second)
}

fn ending(item: &str) -> String {
    format!("And all for the want of a {item}.")
}