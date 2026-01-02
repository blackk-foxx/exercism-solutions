use std::collections::BTreeMap;

pub fn transform(h: &BTreeMap<i32, Vec<char>>) -> BTreeMap<char, i32> {
    h
        .iter()
        .flat_map(|(&n, chars)|
            chars
                  .iter()
                  .map(move |&c| (c.to_ascii_lowercase(), n))
        )
        .collect()
}
