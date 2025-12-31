pub fn egg_count(display_value: u32) -> usize {
    let mut value = display_value as usize;
    let mut count: usize = 0;
    while value > 0 {
        count += value & 1;
        value = value >> 1;
    }
    count
}
