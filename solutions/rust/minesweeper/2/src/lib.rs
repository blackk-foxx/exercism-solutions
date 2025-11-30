pub fn annotate(minefield: &[&str]) -> Vec<String> {
    let row_count = minefield.len();
    (0..row_count).map(|r| {
        let col_count = minefield[0].len();
        (0..col_count).map(|c| get_annotation(minefield, r, c)).collect()
    }).collect()
}

fn get_annotation(minefield: &[&str], r: usize, c: usize) -> char {
    if has_mine(minefield, r, c) {
        '*'
    }
    else {
        get_mine_count_rep(count_neighboring_mines(minefield, r, c)).unwrap()
    }
}

fn get_mine_count_rep(mine_count: usize) -> Option<char> {
    if mine_count == 0 {
        Some(' ')
    }
    else {
        char::from_digit(mine_count as u32, 10)
    }
}

fn has_mine(minefield: &[&str], r: usize, c: usize) -> bool {
    match minefield.get(r) {
        Some(row) => match row.as_bytes().get(c) {
            Some(b) => *b == b'*',
            _ => false
        }
        _ => false
    }
}

pub fn count_neighboring_mines(minefield: &[&str], row: usize, col: usize) -> usize {
    get_neighborhood_coords(minefield, row, col)
        .into_iter()
        .filter(|(r, c)| has_mine(minefield, *r, *c))
        .count()
}

pub fn get_neighborhood_coords(minefield: &[&str], row: usize, col: usize) -> impl Iterator<Item = (usize, usize)> {
    const OFFSETS: [(isize, isize); 8] = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];
    OFFSETS.into_iter().filter_map(move |(dr, dc)| check_add_in_bounds(minefield, row, dr, col, dc))
} 

pub fn check_add_in_bounds(minefield: &[&str], r: usize, dr: isize, c: usize, dc: isize) -> Option<(usize, usize)> {
    let row_count = minefield.len();
    let col_count = minefield[0].len();
    let maybe_row = r.checked_add_signed(dr);
    let maybe_col = c.checked_add_signed(dc);
    match (maybe_row, maybe_col) {
        (Some(r), Some(c)) => 
            if r < row_count && c < col_count { Some((r, c)) } else { None }
        _ => None
    }
}
