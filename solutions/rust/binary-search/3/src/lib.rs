pub fn find(array: &[i32], key: i32) -> Option<usize> {
    if array.is_empty() {
        return None
    }

    let mid = array.len() / 2;
    if key == array[mid] {
        Some(mid)
    }
    else if key < array[mid] {
        find(&array[..mid], key)
    }
    else {
        find(&array[(mid + 1)..], key).map(|i| i + mid + 1)
    } 
}
