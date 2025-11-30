pub fn annotate(garden: &[&str]) -> Vec<String> {
    let height = garden.len();
    (0..height).filter_map(|r| get_annotated_row(garden, r)).collect()
}

fn get_annotated_row(garden: &[&str], row: usize) -> Option<String> {
    let width = garden.get(row)?.len();
    Some(
        (0..width).filter_map(|c| get_annotated_cell(garden, row, c)).collect()
    )
}

fn get_annotated_cell(garden: &[&str], row: usize, col: usize) -> Option<char> {
    if flower_is_at(garden, row, col) { Some('*') }
    else {
        let count = get_nearby_flower_count(garden, row, col);
        if count == 0 { Some(' ') }
        else { char::from_digit(count, 10) }
    }
}

fn get_nearby_flower_count(garden: &[&str], row: usize, col: usize) -> u32 {
    const OFFSETS: [(isize, isize); 8] = [
        (-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)
    ];
    let neighborhood = OFFSETS.into_iter()
        .filter_map(|(dr, dc)| checked_add((row, col), (dr, dc)));
    neighborhood.fold(0, |count, (r, c)| 
        count + flower_is_at(garden, r, c) as u32
    )
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
