#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist(first_list: &[i32], second_list: &[i32]) -> Comparison {
    if first_list == second_list {
        return Comparison::Equal;
    }
    else if first_list.len() > second_list.len() {
        if is_sublist(second_list, first_list) {
            return Comparison::Superlist;
        }
    }
    else if first_list.len() < second_list.len() {
        if is_sublist(first_list, second_list) {
            return Comparison::Sublist;
        }
    }
    Comparison::Unequal
}

pub fn is_sublist(a: &[i32], b: &[i32]) -> bool {
    if a.is_empty() {
        return true;
    }
    for i in 0..(1 + b.len() - a.len()) {
        if a[..] == b[i..(i + a.len())] {
            return true;
        }
    }
    false
}