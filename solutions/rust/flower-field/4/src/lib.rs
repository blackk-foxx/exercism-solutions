pub fn annotate(garden: &[&str]) -> Vec<String> {
    garden.into_iter().enumerate()
        .map(|(r, row)| get_annotated_row(garden, r, row))
        .collect()
}

fn get_annotated_row(garden: &[&str], row_index: usize, row: &str) -> String {
    row.chars().enumerate()
        .filter_map(|(col_index, _)| get_annotated_cell(garden, row_index, col_index))
        .collect()
}

fn get_annotated_cell(garden: &[&str], row: usize, col: usize) -> Option<char> {
    if flower_is_at(garden, row, col) { Some('*') }
    else {
        let count = get_nearby_flower_count(garden, row, col);
        if count == 0 { Some(' ') }
        else { char::from_digit(count as u32, 10) }
    }
}

fn get_nearby_flower_count(garden: &[&str], row: usize, col: usize) -> usize {
    const OFFSETS: [(isize, isize); 8] = [
        (-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)
    ];
    let neighborhood = OFFSETS.into_iter()
        .filter_map(|(dr, dc)| checked_add((row, col), (dr, dc)));
    neighborhood.filter(|(r, c)| flower_is_at(garden, *r, *c)).count()
}

fn checked_add(position: (usize, usize), offset: (isize, isize)) -> Option<(usize, usize)> {
    let (row, col) = position;
    let (dr, dc) = offset;
    Some((row.checked_add_signed(dr)?, col.checked_add_signed(dc)?))
}

fn flower_is_at(garden: &[&str], row: usize, col: usize) -> bool {
    garden.get(row)
        .is_some_and(|items| items.as_bytes().get(col)
            .is_some_and(|c| *c == b'*')
        )
}
