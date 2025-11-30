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
        get_mine_count_rep(count_neighboring_mines(minefield, r, c))
    }
}

fn get_mine_count_rep(mine_count: usize) -> char {
    if mine_count == 0 {
        ' '
    }
    else {
        mine_count.to_string().as_bytes()[0] as char
    }
}

fn has_mine(minefield: &[&str], r: usize, c: usize) -> bool {
    minefield[r].as_bytes()[c] == b'*'
}

pub fn count_neighboring_mines(minefield: &[&str], row: usize, col: usize) -> usize {
    get_neighborhood_coords(minefield, row, col)
        .into_iter()
        .filter(|(r, c)| has_mine(minefield, *r, *c))
        .count()
}

pub fn get_neighborhood_coords(minefield: &[&str], row: usize, col: usize) -> Vec<(usize, usize)> {
    let offsets: [(i32, i32); 8] = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)];
    let coords = offsets.into_iter().map(|(dr, dc)| (row as i32 + dr, col as i32 + dc));
    let valid_coords = coords.filter(|(r, c)| is_in_bounds(minefield, r, c));
    valid_coords.map(|(r, c)| (r as usize, c as usize)).collect()
} 

pub fn is_in_bounds(minefield: &[&str], r: &i32, c: &i32) -> bool {
    let row_count = minefield.len();
    let col_count = minefield[0].len();
    0 <= *r && *r < row_count as i32 && 
    0 <= *c && *c < col_count as i32 
}
