pub fn raindrops(n: u32) -> String {
    let mut result = String::new();
    for (divisor, sound) in [(3, "Pling"), (5, "Plang"), (7, "Plong")] {
        if n % divisor == 0 {
            result += sound;
        }
    }
    if result.is_empty() {
        result = format!("{n}");
    }
    result
}
