pub fn find_saddle_points(input: &[Vec<u64>]) -> Vec<(usize, usize)> {
    let num_rows = input.len();
    let num_cols = input[0].len();
    let columns = (0..num_cols).map(|c| get_column(input, c));
    let max_height_per_row: Vec<u64> = input.iter()
        .filter_map(|row| row.iter().copied().max())
        .collect();
    let min_height_per_col: Vec<u64> = columns
        .filter_map(|col| col.min())
        .collect();
    let all_coords = (0..num_rows)
        .flat_map(|r| {
            (0..num_cols).map(move |c| (r, c))
        });
    all_coords
        .filter(|(r, c)|
            input[*r][*c] == max_height_per_row[*r] && 
            input[*r][*c] == min_height_per_col[*c]
        )
        .collect()
}

fn get_column(rows: &[Vec<u64>], col_index: usize) -> impl Iterator<Item = u64> {
    rows.iter().map(move |row| row[col_index])
}