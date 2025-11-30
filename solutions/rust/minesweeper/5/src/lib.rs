pub fn annotate(minefield: &[&str]) -> Vec<String> {
    let row_count = minefield.len();
    (0..row_count).map(|r| {
        let col_count = minefield[0].len();
        (0..col_count).map(|c| 
            get_annotation(minefield, r, c).unwrap()
        ).collect()
    }).collect()
}

fn get_annotation(minefield: &[&str], row: usize, col: usize) -> Option<char> {
    match get_char_at(minefield, row as isize, col as isize) {
        Some('*') => Some('*'),
        Some(' ') => {
            let mine_count = count_neighboring_mines(minefield, row, col);
            get_mine_count_symbol(mine_count)
        },
        Some(c) => panic!("Invalid symbol {}", c),
        None => None
    }
}

fn get_mine_count_symbol(mine_count: usize) -> Option<char> {
    match mine_count {
        0 => Some(' '),
        n => char::from_digit(n as u32, 10)
    }
}

fn count_neighboring_mines(minefield: &[&str], row: usize, col: usize) -> usize {
    get_neighborhood_coords(row, col)
        .filter(|(r, c)| has_mine(minefield, *r, *c))
        .count()
}

fn has_mine(minefield: &[&str], r: isize, c: isize) -> bool {
    get_char_at(minefield, r, c) == Some('*')
}

fn get_char_at(minefield: &[&str], r: isize, c: isize) -> Option<char> {
    if r < 0 || c < 0 { return None; }
    let result = minefield.get(r as usize)?.as_bytes().get(c as usize)?;
    Some(*result as char)
}

fn get_neighborhood_coords(row: usize, col: usize) -> impl Iterator<Item = (isize, isize)> {
    const OFFSETS: [(isize, isize); 8] = [
        (-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)
    ];
    OFFSETS
        .into_iter()
        .map(move |(dr, dc)| (row as isize + dr, col as isize + dc))
} 
