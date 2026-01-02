pub fn find(array: &[i32], key: i32) -> Option<usize> {
    if array.len() == 0 {
        None
    }
    else {
        let mid = array.len() / 2;
        match key {
            k if k == array[mid] => Some(mid),
            k if k < array[mid] => find(&array[..mid], k),
            k => Some(find(&array[mid..], k)? + mid)
        }
    }
}
